//
//  ContentView.swift
//  wordle
//
//  Created by v.s.zhukov on 25.01.2022.
//

import SwiftUI

struct GameView: View {
    @StateObject var viewModel = GameViewModel(riddle: Ridle.defaultRiddle(), keys: Keys.defaultKeys())
    
    var body: some View {
        Group {
            ZStack {
                GeometryReader { geo in
                    if viewModel.gameState == .loading {
                        shimmers(width: geo.size.width)
                    } else {
                        board(width: geo.size.width)
                    }
                }
                
                switch viewModel.gameState {
                case .win:
                    WinMsgView(onNewGame: {
                        viewModel.onNextRiddle()
                    })
                    .halfTransparentBg()
                case .lose:
                    LoseMsgView(word: viewModel.riddle.answer, onNewGame: {
                        viewModel.onNextRiddle()
                    })
                    .halfTransparentBg()
                case .waitingForNewRidle:
                    WaitingForNewRidleView(
                        viewModel: viewModel.waitingForNewRidleViewModel
                    )
                        .halfTransparentBg()
                default: EmptyView()
                }
            }
        }
            .onAppear {
                viewModel.load()
            }
    }
    
    private func shimmers(width: CGFloat) -> some View {
        VStack {
            BoardShimmerView()
                .padding(.horizontal, 26)
            Spacer(minLength: 0)
            KeyboardShimmerView(keys: viewModel.keys,
                                width: width - 8)
                .padding(.horizontal, 4)
        }.padding(.vertical, 16)
    }
    
    private func board(width: CGFloat) -> some View {
        VStack {
            BoardView(words: viewModel.riddle.words)
                .padding(.horizontal, 26)
            Spacer(minLength: 0)
            KeyboardView(keys: viewModel.keys,
                         width: width - 8,
                         onTap: viewModel.onTap,
                         onEnter: viewModel.onEnter,
                         onRemove: viewModel.onRemove)
                .padding(.horizontal, 4)
        }.padding(.vertical, 16)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
