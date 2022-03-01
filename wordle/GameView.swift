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
            if viewModel.isLoading {
                GeometryReader { geo in
                    VStack {
                        BoardShimmerView()
                            .padding(.horizontal, 26)
                        Spacer(minLength: 0)
                        KeyboardShimmerView(keys: viewModel.keys,
                                            width: geo.size.width - 8)
                            .padding(.horizontal, 4)
                    }.padding(.vertical, 16)
                }
            } else {
                ZStack {
                    GeometryReader { geo in
                        VStack {
                            BoardView(words: viewModel.riddle.words)
                                .padding(.horizontal, 26)
                            Spacer(minLength: 0)
                            KeyboardView(keys: viewModel.keys,
                                         width: geo.size.width - 8,
                                         onTap: viewModel.onTap,
                                         onEnter: viewModel.onEnter,
                                         onRemove: viewModel.onRemove)
                                .padding(.horizontal, 4)
                        }.padding(.vertical, 16)
                    }
                    
                    if viewModel.endGame != .play {
                        ZStack {
                            Color(white: 0, opacity: 0.5)
                                .ignoresSafeArea()
                            
                            if viewModel.endGame == .win {
                                WinMsgView(onNewGame: {

                                })
                            } else {
                                LoseMsgView(onNewGame: {
                                    
                                })
                            }
                        }
                    }
                }
            }
        }
            .onAppear {
                viewModel.load()
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
