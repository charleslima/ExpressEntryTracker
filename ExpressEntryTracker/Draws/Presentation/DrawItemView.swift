//
//  DrawItemView.swift
//  ExpressEntryTracker
//
//  Created by Charles Lima on 2024-04-17.
//

import SwiftUI

struct DrawItemView: View {
    
    let draw: Draw
    
    var body: some View {
        HStack(spacing: 8) {
            VStack(alignment: .leading) {
                Button("#\(draw.drawNumber)") {
                    // TODO
                }
                .font(.caption)
                Text(draw.drawName)
                    .font(.headline)
                    Text("\(Image(systemName: "calendar")) \(draw.drawDateFull)")
                        .font(.footnote)
                        .foregroundStyle(.gray)
            }
            Spacer()
            VStack {
                Text(draw.drawCRS)
                    .frame(width: 48)
                    .foregroundStyle(.white)
                    .font(.headline)
                    .padding(8)
                    .background(Color.green)
                    .clipShape(.capsule)
                Text("\(Image(systemName: "person.2")) \(draw.drawSize)")
                    .font(.caption2)
                    .foregroundStyle(.gray)
            }
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 8)
        
        
    }
}

#Preview {
    DrawItemView(
        draw: Draw(
            drawNumber: "188",
            drawNumberURL: "<a href='/en/immigration-refugees-citizenship/corporate/mandate/policies-operational-instructions-agreements/ministerial-instructions/express-entry-rounds/invitations.html?q=188'>188</a>",
            drawDate: "2021-05-20",
            drawDateFull: "May 20, 2021",
            drawName: "Canadian Experience Class",
            drawSize: "1,842",
            drawCRS: "397",
            drawCutOff: "April 24, 2021 at 12:09:24 UTC",
            drawDistributionAsOn: Date(),
            pool: []
        )
    ).frame(height: 100)
}
