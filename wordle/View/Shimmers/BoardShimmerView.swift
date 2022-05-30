//
//  BoardShimmerView.swift
//  wordle
//
//  Created by v.s.zhukov on 01.03.2022.
//

import SwiftUI

struct BoardShimmerView: View {
    var body: some View {
        VStack(spacing: 6) {
            ForEach((0...5), id: \.self) { index in
                HStack(spacing: 6) {
                    ForEach((0..<5), id: \.self) { index in
                        ShimmerView()
                            .aspectRatio(1, contentMode: .fit)
                            .cornerRadius(4)
                    }
                }
            }
        }
    }
}

struct BoardShimmerView_Previews: PreviewProvider {
    static var previews: some View {
        BoardShimmerView()
    }
}
