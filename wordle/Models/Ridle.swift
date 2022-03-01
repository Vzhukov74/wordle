//
//  Ridle.swift
//  wordle
//
//  Created by v.s.zhukov on 22.02.2022.
//

import Foundation

struct Ridle {
    var words: [Word]
    var currentWordIndex: Int
    var currentCharIndex: Int
    
    let answer: String
    let availableUntil: String
}

extension Ridle {
    static func create(for answer: String, availableUntil: String) -> Ridle {
        return Ridle(
            words: Array(repeating: Word(numberOfChars: answer.count), count: answer.count + 1),
            currentWordIndex: 0,
            currentCharIndex: 0,
            answer: answer,
            availableUntil: availableUntil
        )
    }
    
    static func defaultRiddle() -> Ridle {
        create(for: "ПРИВЕТ", availableUntil: "2/8")
    }
}
