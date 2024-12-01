//
//  DrawMock.swift
//  ExpressEntryTracker
//
//  Created by Charles Lima on 2024-12-01.
//

import Foundation
@testable import ExpressEntryTracker

extension Draw {
    static func mock(
        drawNumber: String = "327",
        drawNumberURL: String = "url",
        drawDate: String = "2024-11-20",
        drawDateFull: String = "November 20, 2024",
        drawName: String = "Healthcare occupations (Version 1)",
        drawSize: String = "3,000",
        drawCRS: String = "463",
        drawCutOff: String = "October 21, 2024 at 16:12:39 UTC",
        drawDistributionAsOn: Date = Date(),
        pool: [ScorePool] = []
    ) -> Draw {
        Draw(
            drawNumber: drawNumber,
            drawNumberURL: drawNumberURL,
            drawDate: drawDate,
            drawDateFull: drawDateFull,
            drawName: drawName,
            drawSize: drawSize,
            drawCRS: drawCRS,
            drawCutOff: drawCutOff,
            drawDistributionAsOn: drawDistributionAsOn,
            pool: pool
        )
    }
}


