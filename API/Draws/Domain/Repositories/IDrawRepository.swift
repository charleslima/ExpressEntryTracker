//
//  IDrawRepository.swift
//  API
//
//  Created by Charles Lima on 2024-04-18.
//

import Foundation

public protocol IDrawRepository {
    func draws() async throws -> [Draw]
}
