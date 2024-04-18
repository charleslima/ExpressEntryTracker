//
//  DrawItemShimmerView.swift
//  ExpressEntryTracker
//
//  Created by Charles Lima on 2024-04-17.
//

import SwiftUI
import DesignSystem

struct DrawItemShimmerView: View {
    
    var body: some View {
        HStack(spacing: 8) {
            VStack(alignment: .leading) {
                ShimmerView().frame(width: 32, height: 12)
                ShimmerView().frame(width: 200, height: 16)
                ShimmerView().frame(width: 100, height: 16)
            }
            Spacer()
            VStack {
                ShimmerView().frame(width: 48, height: 16)
                    .font(.headline)
                    .padding(8)
                ShimmerView().frame(width: 44, height: 16)
            }
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 8)
    }
}

#Preview {
    DrawItemShimmerView().frame(height: 100)
}
