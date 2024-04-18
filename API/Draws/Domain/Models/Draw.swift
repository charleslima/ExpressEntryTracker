//
//  Draw.swift
//  API
//
//  Created by Charles Lima on 2024-04-18.
//

public struct Draw {
    
    public let drawNumber: String
    public let drawNumberURL: String
    public let drawDate: String
    public let drawDateFull: String
    public let drawName: String
    public let drawSize: String
    public let drawCRS: String
    public let drawCutOff: String
    
    public init(drawNumber: String, drawNumberURL: String, drawDate: String, drawDateFull: String, drawName: String, drawSize: String, drawCRS: String, drawCutOff: String) {
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
