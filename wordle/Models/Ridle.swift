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
    
    let id: String
    let answer: String
    let availableUntil: String
}

extension Ridle {
    static func create(for answer: String, availableUntil: String) -> Ridle {
        return Ridle(
            words: Array(repeating: Word(numberOfChars: answer.count), count: answer.count + 1),
            currentWordIndex: 0,
            currentCharIndex: 0,
            id: answer,
            answer: answer,
            availableUntil: availableUntil
        )
    }
    
    static func defaultRiddle() -> Ridle {
        //let dateFormatter = DateFormatter()
        //dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        let availableUntil = "2022-05-30 23:59"//dateFormatter.string(from: Date())
        
        let words = ["ПРИВЕТ", "МАГНИТ", "ОБЛАКО", "МОЛОКО", "АРБУЗЫ"]
        
        return create(for: words.randomElement()!, availableUntil: availableUntil)
    }
}
