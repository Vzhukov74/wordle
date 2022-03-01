//
//  LoseMsgView.swift
//  wordle
//
//  Created by v.s.zhukov on 01.03.2022.
//

import SwiftUI

struct LoseMsgView: View {
    var onNewGame: () -> Void
    
    var body: some View {
        VStack(spacing: 12) {
            Text("Упс, вы исчерпали все попыки!")
                .font(Font.title2)
                .padding()
            Button(action: onNewGame) {
                Text("Продолжить отгадывать!")
                    .font(Font.headline)
                    .foregroundColor(Color.white)
                    .padding()
            }
                .background(Color.red)
                .cornerRadius(24)
                .padding()
        }
            .background(Color.white)
            .cornerRadius(8)
            .shadow(color: Color(white: 0, opacity: 0.5), radius: 8, x: 4, y: 4)
    }
}

struct LoseMsgView_Previews: PreviewProvider {
    static var previews: some View {
        LoseMsgView(onNewGame: {})
            .previewLayout(.sizeThatFits)
    }
}
