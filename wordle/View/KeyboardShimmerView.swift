//
//  KeyboardShimmerView.swift
//  wordle
//
//  Created by v.s.zhukov on 01.03.2022.
//

import SwiftUI

struct KeyboardShimmerView: View {
    let keys: Keys
    let width: CGFloat
    
    var body: some View {
        let width = shimmerSize(width: width, keys: keys)
        
        VStack(spacing: 4) {            
            ForEach(keys.rows.indices, id: \.self) { rowIndex in
                HStack(spacing: 4) {
                    ForEach(keys.rows[rowIndex].chars.indices, id: \.self) { charIndex in
                        ShimmerView()
                            .frame(width: width)
                            .aspectRatio(1, contentMode: .fit)
                            .cornerRadius(4)
                    }
                }
                    .frame(height: width)
            }
            
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: width, height: width)
        }
        .font(Font.system(size: width * 0.6, weight: .semibold, design: .rounded))
        .frame(alignment: .bottom)
    }
    
    private func shimmerSize(width: CGFloat, keys: Keys) -> CGFloat {
        guard keys.rows.count <= 3 else { return .zero }
        
        guard let maxCharsRow = keys.rows.compactMap({ $0.chars.count }).sorted(by:>).first else { return .zero }
        
        let charWidth = (width / CGFloat(maxCharsRow)) - 4
        
        return charWidth
    }
}

struct KeyboardShimmerView_Previews: PreviewProvider {
    static var previews: some View {
        KeyboardShimmerView(keys: Keys.defaultKeys(), width: UIScreen.main.bounds.width)
    }
}
