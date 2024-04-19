//
//  InboundDraw.swift
//  API
//
//  Created by Charles Lima on 2024-04-17.
//

struct InboundDraw: Decodable {
    let drawNumber: String
    let drawNumberURL: String
    let drawDate: String
    let drawDateFull: String
    let drawName: String
    let drawSize: String
    let drawCRS: String
    let drawCutOff: String
}

extension InboundDraw {
    var asDomainModel: Draw {
        
        let drawURL = {
            let elements = self.drawNumberURL.split(separator: "'")
            let url = elements.indices.contains(1) ? elements[1] : ""
            return Config.host + url
        }()
        
        return Draw(drawNumber: self.drawNumber,
                    drawNumberURL: String(drawURL),
                    drawDate: self.drawDate,
                    drawDateFull: self.drawDateFull,
                    drawName: self.drawName,
                    drawSize: self.drawSize,
                    drawCRS: self.drawCRS,
                    drawCutOff: self.drawCutOff)
    }
}
