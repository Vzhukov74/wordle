//
//  WaitingForNewRidleView.swift
//  wordle
//
//  Created by v.s.zhukov on 30.05.2022.
//

import SwiftUI

struct WaitingForNewRidleView: View {
    
    @StateObject var viewModel: WaitingForNewRidleViewModel

    var body: some View {
        VStack(spacing: 8) {
            Text("Новое слово будет\nдоступно через: ")
                .multilineTextAlignment(.center)
                .font(Font.title3)
                .padding(.top, 12)
                .padding(.horizontal, 16)
            Text(viewModel.availableAfter)
                .font(Font.system(size: 24, weight: .bold, design: .monospaced))
                .padding(.top, 12)
                .padding(.bottom, 20)
                .padding(.horizontal, 16)
        }
            .background(Color.white)
            .cornerRadius(8)
            .shadow(color: Color(white: 0, opacity: 0.5), radius: 8, x: 4, y: 4)
            .onAppear { viewModel.startCountDown() }
    }
}

struct WaitingForNewRidleView_Previews: PreviewProvider {
    static var previews: some View {
        WaitingForNewRidleView(viewModel: WaitingForNewRidleViewModel(unavailableUntil: ""))
            .previewLayout(.sizeThatFits)
    }
}
