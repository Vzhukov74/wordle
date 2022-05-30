//
//  CharView.swift
//  wordle
//
//  Created by v.s.zhukov on 22.02.2022.
//

import SwiftUI

struct CharView: View {
    let char: Char
        
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 4)
                .foregroundColor(char.highlight.bgColor)
                .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(char.highlight.borderColor, lineWidth: 3)
                )
            
            Text(char.title)
                .foregroundColor(Color.black)
        }
            .aspectRatio(1, contentMode: .fit)
    }
}

struct CharView_Previews: PreviewProvider {
    static var previews: some View {
        CharView(char: Char(title: "F", highlight: .correct))
            .previewLayout(PreviewLayout.fixed(width: 100, height: 100))
        CharView(char: Char(title: "F", highlight: .wrong))
            .previewLayout(PreviewLayout.fixed(width: 100, height: 100))
        CharView(char: Char(title: "F", highlight: .wrongPlace))
            .previewLayout(PreviewLayout.fixed(width: 100, height: 100))
        CharView(char: Char(title: "", highlight: .none))
            .previewLayout(PreviewLayout.fixed(width: 100, height: 100))
    }
}

private extension CharHighlight {
    var bgColor: Color {
        switch self {
        case .none: return .clear
        case .wrong: return Color(uiColor: .darkGray)
        case .correct: return Color(uiColor: .systemGreen)
        case .wrongPlace: return Color(uiColor: .systemOrange)
        }
    }
    
    var borderColor: Color {
        self == .none ? Color(uiColor: .lightGray) : .clear
    }
}
