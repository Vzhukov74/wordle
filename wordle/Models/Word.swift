//
//  Word.swift
//  wordle
//
//  Created by v.s.zhukov on 22.02.2022.
//

import SwiftUI
import Combine

struct Word {
    var chars: [Char] = []
    var wrongAnswerCounter: Int = 0
    
    init(numberOfChars: Int) {
        self.chars = Array(repeating: Char(title: "", highlight: .none), count: numberOfChars)
    }
    
    init(chars: [Char]) {
        self.chars = chars
    }
}
