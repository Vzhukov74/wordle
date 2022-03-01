//
//  GameViewModel.swift
//  wordle
//
//  Created by v.s.zhukov on 22.02.2022.
//

import SwiftUI
import Combine

final class GameViewModel: ObservableObject {
    enum EndGameState {
        case play, win, lose
    }
    
    private let ridleProvider = RidleProvider()
    
    @Published var isLoading: Bool = true
    @Published var riddle: Ridle
    @Published var keys: Keys
    @Published var endGame: EndGameState = .play
    
    init(riddle: Ridle, keys: Keys) {
        self.riddle = riddle
        self.keys = keys
    }
    
    func load() {
        isLoading = true
        ridleProvider.fetch { [weak self] ridle in
            if let ridle = ridle {
                self?.endGame = .play
                self?.riddle = ridle
            }
            self?.isLoading = false
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
        
        let word = riddle.words[riddle.currentWordIndex].chars.compactMap({ $0.title }).joined()
        
        if word == riddle.answer {
            endGame = .win
        } else {
            if riddle.currentWordIndex == riddle.words.count - 1 {
                endGame = .lose
            } else {
                goToNextTry()
            }
        }
    }
    
    func onRemove() {
        guard riddle.currentWordIndex < riddle.words.count else { return }
        guard riddle.currentCharIndex < riddle.words[riddle.currentWordIndex].chars.count else { return }
        
        if riddle.words[riddle.currentWordIndex].chars[riddle.currentCharIndex].title.isEmpty {
            riddle.currentCharIndex = riddle.currentCharIndex - 1
            if riddle.currentCharIndex < 0 {
                riddle.currentCharIndex = 0
            }
            onRemove()
        } else {
            riddle.words[riddle.currentWordIndex].chars[riddle.currentCharIndex] = Char(title: "", highlight: .none)
        }
    }
    
    
    
    private func goToNextTry() {
        var word = riddle.words[riddle.currentWordIndex]
        var newkKeys = keys
        
        for index in 0..<word.chars.count {
            if let char = word.chars[index].title.first {
                if riddle.answer.contains(char) {
                    let indexes = riddle.answer.indexes(of: char)
                    if indexes.contains(index) {
                        word.chars[index].highlight = .correct
                        if let keyIndexes = self.keyIndexes(for: word.chars[index]) {
                            let newKey = Char(title: keys.rows[keyIndexes.0].chars[keyIndexes.1].title, highlight: .correct)
                            newkKeys.rows[keyIndexes.0].chars[keyIndexes.1] = newKey
                        }
                    } else {
                        word.chars[index].highlight = .wrongPlace
                        if let keyIndexes = self.keyIndexes(for: word.chars[index]) {
                            let newKey = Char(title: keys.rows[keyIndexes.0].chars[keyIndexes.1].title, highlight: .wrongPlace)
                            newkKeys.rows[keyIndexes.0].chars[keyIndexes.1] = newKey
                        }
                    }
                } else {
                    word.chars[index].highlight = .wrong
                    if let keyIndexes = self.keyIndexes(for: word.chars[index]) {
                        let newKey = Char(title: keys.rows[keyIndexes.0].chars[keyIndexes.1].title, highlight: .wrong)
                        newkKeys.rows[keyIndexes.0].chars[keyIndexes.1] = newKey
                    }
                }
            }
        }
                
        riddle.words[riddle.currentWordIndex] = word
        keys = newkKeys
        
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
