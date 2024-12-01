//
//  APIDrawMock.swift
//  ExpressEntryTracker
//
//  Created by Charles Lima on 2024-12-01.
//

import API

extension API.Draw {
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
        dd1: String = "100",
        dd2: String = "16,495",
        dd3: String = "64,596",
        dd4: String = "12,208",
        dd5: String = "12,318",
        dd6: String = "15,238",
        dd7: String = "13,141",
        dd8: String = "11,691",
        dd9: String = "57,062",
        dd10: String = "11,045",
        dd11: String = "12,196",
        dd12: String = "11,113",
        dd13: String = "11,463",
        dd14: String = "11,245",
        dd15: String = "51,434",
        dd16: String = "22,865",
        dd17: String = "5,615",
        dd18: String = "218,167"
        
    ) -> API.Draw {
        API.Draw(
            drawNumber: drawNumber,
            drawNumberURL: drawNumberURL,
            drawDate: drawDate,
            drawDateFull: drawDateFull,
            drawName: drawName,
            drawSize: drawSize,
            drawCRS: drawCRS,
            drawCutOff: drawCutOff,
            drawDistributionAsOn: drawDistributionAsOn,
            dd1: dd1, dd2: dd2, dd3: dd3, dd4: dd4, dd5: dd5, dd6: dd6, dd7: dd7, dd8: dd8, dd9: dd9, dd10: dd10,
            dd11: dd11, dd12: dd12, dd13: dd13, dd14: dd14, dd15: dd15, dd16: dd16, dd17: dd17, dd18: dd18
        )
    }
}


