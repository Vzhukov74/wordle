//
//  ShimmerView.swift
//  wordle
//
//  Created by v.s.zhukov on 01.03.2022.
//

import SwiftUI

struct ShimmerView: View {
    private struct Constants {
        static let duration: Double = 0.9
        static let minOpacity: Double = 0.25
        static let maxOpacity: Double = 1.0
        static let cornerRadius: CGFloat = 2.0
    }
    
    @State private var opacity: Double = Constants.minOpacity
    
    public init() {}
    
    public var body: some View {
        RoundedRectangle(cornerRadius: Constants.cornerRadius)
            .fill(Color(uiColor: .lightGray))
            .opacity(opacity)
            .transition(.opacity)
            .onAppear {
                let baseAnimation = Animation.easeInOut(duration: Constants.duration)
                let repeated = baseAnimation.repeatForever(autoreverses: true)
                withAnimation(repeated) {
                    self.opacity = Constants.maxOpacity
                }
        }
    }
}

struct ShimmerView_Previews: PreviewProvider {
    static var previews: some View {
        ShimmerView()
    }
}
