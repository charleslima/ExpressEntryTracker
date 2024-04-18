//
//  ShimmerView.swift
//  DesignSystem
//
//  Created by Charles Lima on 2024-04-18.
//

import SwiftUI

public struct ShimmerView: View {

    @State private var shimmering = false
    private var primaryColor: Color
    private var secondaryColor: Color
    
    public init() {
        self.primaryColor = Color(#colorLiteral(red: 0.9015986919, green: 0.9015986919, blue: 0.9015986919, alpha: 1))
        self.secondaryColor = Color(#colorLiteral(red: 0.9584004283, green: 0.9584004283, blue: 0.9584004283, alpha: 1))
    }
    
    public init(primaryColor: Color, secondaryColor: Color) {
        self.primaryColor = primaryColor
        self.secondaryColor = secondaryColor
    }
    
    public var body: some View {
        LinearGradient(colors: [primaryColor, secondaryColor],
                       startPoint: .leading,
                       endPoint: shimmering ? .trailing : .leading)
        .mask(RoundedRectangle(cornerRadius: 4))
        .animation(.easeOut(duration: 1).repeatForever(autoreverses: false),
                   value: shimmering)
        .onAppear(perform: {
            shimmering.toggle()
        })
    }
}

#Preview {
    ShimmerView().frame(width: 100, height: 22)
}
