//
//  WordView.swift
//  wordle
//
//  Created by v.s.zhukov on 25.01.2022.
//

import SwiftUI

struct WordView: View {
    let word: Word
    
    var body: some View {
        HStack(spacing: 6) {
            ForEach((0..<word.chars.count), id: \.self) { index in
                CharView(char: word.chars[index])
            }
        }
            .modifier(Shake(animatableData: CGFloat(word.wrongAnswerCounter)))
            .animation(.default, value: word.wrongAnswerCounter)
    }
}

struct WordView_Previews: PreviewProvider {
    static var previews: some View {
        WordView(word: Word.previewsData)
    }
}

extension Word {
    static let previewsData = Word(chars: [
        Char(title: "W", highlight: .wrong),
        Char(title: "O", highlight: .correct),
        Char(title: "R", highlight: .wrongPlace),
        Char(title: "", highlight: .none),
        Char(title: "", highlight: .none)
    ])
}
