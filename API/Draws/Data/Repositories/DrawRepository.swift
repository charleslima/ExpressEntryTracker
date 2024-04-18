//
//  DrawRepository.swift
//  API
//
//  Created by Charles Lima on 2024-04-18.
//

import Foundation

public class DrawRepository: IDrawRepository {
    
    private let api: DrawAPI
    
    public init() {
        api = DrawAPI()
    }
    
    public func draws() async throws -> [Draw] {
        let inboundDraws = try await api.draws()
        return inboundDraws.map {
            Draw(drawNumber: $0.drawNumber,
                 drawNumberURL: $0.drawNumberURL,
                 drawDate: $0.drawDate,
                 drawDateFull: $0.drawDateFull,
                 drawName: $0.drawName,
                 drawSize: $0.drawSize,
                 drawCRS: $0.drawCRS,
                 drawCutOff: $0.drawCutOff)
        }
    }
}
