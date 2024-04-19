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
            $0.asDomainModel
        }
    }
}
