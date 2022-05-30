//
//  GameViewModel.swift
//  wordle
//
//  Created by v.s.zhukov on 22.02.2022.
//

import SwiftUI
import Combine

final class GameViewModel: ObservableObject {
    enum GameState {
        case play, win, lose, waitingForNewRidle, loading
    }
    
    private let ridleProvider = RidleProvider()
    private let lastRidleIdStore = LastRidleIdStore()
    
    @Published var riddle: Ridle
    @Published var keys: Keys
    @Published var gameState: GameState = .loading
    
    init(riddle: Ridle, keys: Keys) {
        self.riddle = riddle
        self.keys = keys
    }
    
    func load() {
        gameState = .loading
        ridleProvider.fetch { [weak self] in
            self?.handleNew(newRiddle: $0)
        }
    }
    
    func onTap(_ char: String) {
        guard char.count == 1 else { return }
        guard riddle.currentWordIndex < riddle.words.count else { return }
        guard riddle.currentCharIndex < riddle.words[riddle.currentWordIndex].chars.count else { return }
        guard riddle.words[riddle.currentWordIndex].chars[riddle.currentCharIndex].title.isEmpty else { return }
        
        riddle.words[riddle.currentWordIndex].chars[riddle.currentCharIndex] = Char(title: char.uppercased(), highlight: .none)
        
        riddle.currentCharIndex = riddle.currentCharIndex + 1
        if riddle.currentCharIndex == riddle.words[riddle.currentWordIndex].chars.count {
            riddle.currentCharIndex = riddle.words[riddle.currentWordIndex].chars.count - 1
        }
    }
    
    func onEnter() {
        guard riddle.currentWordIndex < riddle.words.count else { return }
        
        lightUpChars()
        
        let word = riddle.words[riddle.currentWordIndex].chars.compactMap({ $0.title }).joined()
        
        if word == riddle.answer {
            gameState = .win
            lastRidleIdStore.saveLastRidle(id: riddle.id)
        } else if riddle.currentWordIndex == riddle.words.count - 1 {
            gameState = .lose
        } else {
            goToNextTry()
        }
    }
    
    func onRemove() {
        guard riddle.currentWordIndex < riddle.words.count else { return }
        guard riddle.currentCharIndex < riddle.words[riddle.currentWordIndex].chars.count else { return }
        
        if riddle.words[riddle.currentWordIndex].chars[riddle.currentCharIndex].title.isEmpty {
            riddle.currentCharIndex -= 1
            if riddle.currentCharIndex < 0 {
                riddle.currentCharIndex = 0
            } else {
                onRemove()
            }
        } else {
            riddle.words[riddle.currentWordIndex].chars[riddle.currentCharIndex] = Char(title: "", highlight: .none)
        }
    }
    
    func onNextRiddle() {
        load()
    }
    
    // MARK: private
    
    private func handleNew(newRiddle: Ridle?) {
        guard let newRiddle = newRiddle else { return }
        
        if lastRidleIdStore.getLastRidleId() == newRiddle.id {
            gameState = .waitingForNewRidle
        } else {
            gameState = .play
            riddle = newRiddle
        }
    }
    
    private func lightUpChars() {
        var word = riddle.words[riddle.currentWordIndex]
        var newkKeys = keys
        
        for index in 0..<word.chars.count {
            guard let char = word.chars[index].title.first else { return }
            
            if riddle.answer.contains(char) {
                let indexes = riddle.answer.indexes(of: char)
                if indexes.contains(index) { // Correct
                    word.chars[index].highlight = .correct
                    if let keyIndexes = keyIndexes(for: word.chars[index]) {
                        let newKey = Char(title: keys.rows[keyIndexes.0].chars[keyIndexes.1].title, highlight: .correct)
                        newkKeys.rows[keyIndexes.0].chars[keyIndexes.1] = newKey
                    }
                } else { // Correct but on wrong place
                    word.chars[index].highlight = .wrongPlace
                    if let keyIndexes = keyIndexes(for: word.chars[index]) {
                        let newKey = Char(title: keys.rows[keyIndexes.0].chars[keyIndexes.1].title, highlight: .wrongPlace)
                        newkKeys.rows[keyIndexes.0].chars[keyIndexes.1] = newKey
                    }
                }
            } else {
                word.chars[index].highlight = .wrong
                if let keyIndexes = keyIndexes(for: word.chars[index]) {
                    let newKey = Char(title: keys.rows[keyIndexes.0].chars[keyIndexes.1].title, highlight: .wrong)
                    newkKeys.rows[keyIndexes.0].chars[keyIndexes.1] = newKey
                }
            }
        }
                
        riddle.words[riddle.currentWordIndex] = word
        keys = newkKeys
    }
    
    private func goToNextTry() {
        riddle.currentWordIndex = riddle.currentWordIndex + 1
        riddle.currentCharIndex = 0
    }
    
    private func keyIndexes(for char: Char) -> (Int, Int)? {
        for rowIndex in keys.rows.indices {
            if keys.rows[rowIndex].chars.contains(where: { $0.title.lowercased() == char.title.lowercased() }) {
                if let charIndex = keys.rows[rowIndex].chars.firstIndex(where: { $0.title.lowercased() == char.title.lowercased() }) {
                    return (rowIndex, charIndex)
                }
            }
        }
        
        return nil
    }
}

extension GameViewModel {
    var waitingForNewRidleViewModel: WaitingForNewRidleViewModel {
        WaitingForNewRidleViewModel(unavailableUntil: riddle.availableUntil)
    }
}

extension String {
    func indexes(of char: Character) -> [Int] {
        var indexes: [Int] = []
        for index in 0..<self.count {
            if self[index] == char {
                indexes.append(index)
            }
        }
        return indexes
    }
}

extension StringProtocol {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
}
