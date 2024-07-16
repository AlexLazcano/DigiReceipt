//
//  Modifiers.swift
//  DigiReceipt
//
//  Created by Alex Lazcano on 2024-07-16.
//

import Foundation
import SwiftUI

struct GradientBackgroundStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(LinearGradient(colors: [.blue, .purple], startPoint: .topLeading, endPoint: .bottomTrailing), in: RoundedRectangle(cornerRadius: 16))
            .foregroundColor(.white)
            .font(.title)
            .bold()
    }
}

extension View {
    func applyGradientBackgroundStyle() -> some View {
        self.modifier(GradientBackgroundStyle())
    }
}



