//
//  BoardView.swift
//  wordle
//
//  Created by v.s.zhukov on 08.02.2022.
//

import SwiftUI

struct BoardView: View {
    let words: [Word]
    
    var body: some View {
        VStack(spacing: 6) {
            ForEach((0...5), id: \.self) { index in
                WordView(word: words[index])
            }
        }
    }
}

struct BoardView_Previews: PreviewProvider {
    static var previews: some View {
        BoardView(words: Array(repeating: Word.previewsData, count: 6))
            .padding()
    }
}
