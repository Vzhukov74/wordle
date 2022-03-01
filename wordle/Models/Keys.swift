//
//  Keys.swift
//  wordle
//
//  Created by v.s.zhukov on 24.02.2022.
//

import Foundation

struct Keys {
    var rows: [KeysRow]
}

extension Keys {
    static func initFrom(keysStrs: [String]) -> Keys {
        let rows = keysStrs.compactMap {
            KeysRow(chars: $0.compactMap { Char(title: String($0), highlight: .none) })
        }
        
        return Keys(rows: rows)
    }
    
    static func defaultKeys() -> Keys {
        let keysStrs = [
            "йцукенгшщзхъ",
            "фывапролджэ",
            "ёячсмитьбю"
        ]
        
        return Keys.initFrom(keysStrs: keysStrs)
    }
}
