//
//  InboundDrawResponse.swift
//  API
//
//  Created by Charles Lima on 2024-04-17.
//

import Foundation

struct InboundDrawResponse: Decodable {
    let rounds: [InboundDraw]
}
