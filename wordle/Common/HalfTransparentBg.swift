//
//  HalfTransparentBg.swift
//  wordle
//
//  Created by v.s.zhukov on 30.05.2022.
//

import SwiftUI

struct HalfTransparentBg: ViewModifier {
    func body(content: Content) -> some View {
        ZStack {
            Color(white: 0, opacity: 0.5).ignoresSafeArea()
            content
        }
    }
}

extension View {
    func halfTransparentBg() -> some View {
        modifier(HalfTransparentBg())
    }
}
