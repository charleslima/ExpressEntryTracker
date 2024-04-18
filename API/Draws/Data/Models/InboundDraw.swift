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
