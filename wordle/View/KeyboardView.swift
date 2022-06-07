//
//  KeyboardView.swift
//  wordle
//
//  Created by v.s.zhukov on 26.01.2022.
//

import SwiftUI

struct KeyboardView: View {
    
    let keys: Keys
    let width: CGFloat
    let onTap: (_ char: String) -> Void
    let onEnter: () -> Void
    let onRemove: () -> Void
        
    var body: some View {
        let width = charSize(width: width, keys: keys)
        
        VStack(spacing: 4) {
            HStack {
                Spacer(minLength: 0)
                deleteButton
                    .frame(width: width * 2 + 4, height: width)
                    .background(Color(uiColor: .systemGroupedBackground))
                    .cornerRadius(4)
            }
            
            ForEach(keys.rows.indices, id: \.self) { rowIndex in
                HStack(spacing: 4) {
                    ForEach(keys.rows[rowIndex].chars.indices, id: \.self) { charIndex in
                        charView(keys.rows[rowIndex].chars[charIndex], width: width)
                    }
                }
                    .frame(height: width)
            }
            
            doneButton
                .frame(width: width * 4 + 12, height: width)
                .background(Color(uiColor: .systemGroupedBackground))
                .cornerRadius(4)
        }
        .font(Font.system(size: width * 0.6, weight: .semibold, design: .rounded))
        .frame(alignment: .bottom)
    }
    
    private var deleteButton: some View {
        Button(action: onRemove) {
            HStack {
                Spacer(minLength: 0)
                Image(systemName: "delete.left")
                    .foregroundColor(Color.red)
                    .padding(.horizontal, 7)
            }
        }
    }
    
    private var doneButton: some View {
        Button(action: onEnter) {
            Text("ВВОД")
                .foregroundColor(Color(uiColor: .systemGreen))
        }
    }
    
    private func charSize(width: CGFloat, keys: Keys) -> CGFloat {
        guard keys.rows.count <= 3 else { return .zero }
        
        guard let maxCharsRow = keys.rows.compactMap({ $0.chars.count }).sorted(by:>).first else { return .zero }
        
        let charWidth = (width / CGFloat(maxCharsRow)) - 4
        
        return charWidth
    }
    
    private func charView(_ char: Char, width: CGFloat) -> some View {
        RoundedRectangle(cornerRadius: 4)
            .foregroundColor(char.highlight.keyboardBg)
            .overlay {
                Text(char.title)
            }
            .frame(width: width)
            .aspectRatio(1, contentMode: .fit)
            .onTapGesture {
                onTap(char.title)
            }
    }
}

struct KeyboardView_Previews: PreviewProvider {
    static var previews: some View {
        KeyboardView(keys: Keys.defaultKeys(), width: UIScreen.main.bounds.width, onTap: {_ in}, onEnter: {}, onRemove: {})
    }
}

private extension CharHighlight {
    var keyboardBg: Color {
        switch self {
        case .none: return Color(uiColor: .systemGroupedBackground)
        case .correct: return Color(uiColor: .systemGreen)
        case .wrongPlace: return Color(uiColor: .systemOrange)
        case .wrong: return Color(uiColor: .darkGray)
        }
    }
}
