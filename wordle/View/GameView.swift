//
//  GameView.swift
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
                        EmptyView()
                    } else {
                        board(width: geo.size.width)
                    }
                }
                
                switch viewModel.gameState {
                case .win:
                    EmptyView()
                case .lose:
                    EmptyView()
                case .waitingForNewRidle:
                    EmptyView()
                default: EmptyView()
                }
            }
        }
            .onAppear {
                viewModel.load()
            }
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
