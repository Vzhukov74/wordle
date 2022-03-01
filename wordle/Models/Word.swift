//
//  Word.swift
//  wordle
//
//  Created by v.s.zhukov on 22.02.2022.
//

import Foundation

struct Word {
    var chars: [Char] = []
    
    init(numberOfChars: Int) {
        self.chars = Array(repeating: Char(title: "", highlight: .none), count: numberOfChars)
    }
    
    init(chars: [Char]) {
        self.chars = chars
    }
}
