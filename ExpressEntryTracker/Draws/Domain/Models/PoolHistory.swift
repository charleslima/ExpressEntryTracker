//
//  PoolHistory.swift
//  ExpressEntryTracker
//
//  Created by Charles Lima on 2024-04-25.
//

import Foundation

struct PoolHistory {
    let range: ScoreRange
    let history: [Mark]
    
    struct Mark: Hashable {
        var date: Date
        var candidates: Int
    }
}

extension PoolHistory: Equatable {
    static func == (lhs: PoolHistory, rhs: PoolHistory) -> Bool {
        lhs.range == rhs.range &&
        lhs.history == rhs.history
    }
}
