//
//  Draw.swift
//  ExpressEntryTracker
//
//  Created by Charles Lima on 2024-04-18.
//

import Foundation

struct Draw {
    
    let drawNumber: String
    let drawNumberURL: String
    let drawDate: String
    let drawDateFull: String
    let drawName: String
    let drawSize: String
    let drawCRS: String
    let drawCutOff: String
    
    init(drawNumber: String, drawNumberURL: String, drawDate: String, drawDateFull: String, drawName: String, drawSize: String, drawCRS: String, drawCutOff: String) {
        self.drawNumber = drawNumber
        self.drawNumberURL = drawNumberURL
        self.drawDate = drawDate
        self.drawDateFull = drawDateFull
        self.drawName = drawName
        self.drawSize = drawSize
        self.drawCRS = drawCRS
        self.drawCutOff = drawCutOff
    }
}

extension Draw: Hashable {
    static func == (lhs: Draw, rhs: Draw) -> Bool {
        lhs.drawNumber == rhs.drawNumber &&
        lhs.drawNumberURL == rhs.drawNumberURL &&
        lhs.drawDate == rhs.drawDate &&
        lhs.drawDateFull == rhs.drawDateFull &&
        lhs.drawName == rhs.drawName &&
        lhs.drawSize == rhs.drawSize &&
        lhs.drawCRS == rhs.drawCRS &&
        lhs.drawCutOff == rhs.drawCutOff
    }
}
