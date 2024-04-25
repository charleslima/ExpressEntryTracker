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
    let drawDistributionAsOn: String
    let dd1: String
    let dd2: String
    let dd3: String
    let dd4: String
    let dd5: String
    let dd6: String
    let dd7: String
    let dd8: String
    let dd9: String
    let dd10: String
    let dd11: String
    let dd12: String
    let dd13: String
    let dd14: String
    let dd15: String
    let dd16: String
    let dd17: String
    let dd18: String
}

extension InboundDraw {
    var asDomainModel: Draw {
        
        let drawURL = {
            let elements = self.drawNumberURL.split(separator: "'")
            let url = elements.indices.contains(1) ? elements[1] : ""
            return Config.host + url
        }()
        
        let drawDistributionAsOn = {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMM d, yyyy"
            return dateFormatter.date(from: self.drawDistributionAsOn) ?? Date()
        }()
        
        return Draw(drawNumber: self.drawNumber,
                    drawNumberURL: String(drawURL),
                    drawDate: self.drawDate,
                    drawDateFull: self.drawDateFull,
                    drawName: self.drawName,
                    drawSize: self.drawSize,
                    drawCRS: self.drawCRS,
                    drawCutOff: self.drawCutOff,
                    drawDistributionAsOn: drawDistributionAsOn,
                    dd1: self.dd1,
                    dd2: self.dd2,
                    dd3: self.dd3,
                    dd4: self.dd4,
                    dd5: self.dd5,
                    dd6: self.dd6,
                    dd7: self.dd7,
                    dd8: self.dd8,
                    dd9: self.dd9,
                    dd10: self.dd10,
                    dd11: self.dd11,
                    dd12: self.dd12,
                    dd13: self.dd13,
                    dd14: self.dd14,
                    dd15: self.dd15,
                    dd16: self.dd16,
                    dd17: self.dd17,
                    dd18: self.dd18
        )
    }
}
