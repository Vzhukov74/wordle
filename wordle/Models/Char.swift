//
//  Char.swift
//  wordle
//
//  Created by v.s.zhukov on 22.02.2022.
//

import Foundation

enum CharHighlight: Hashable {
    case none
    case correct
    case wrongPlace
    case wrong
}

struct Char: Hashable {
    var title: String = ""
    var highlight: CharHighlight = .none
}
