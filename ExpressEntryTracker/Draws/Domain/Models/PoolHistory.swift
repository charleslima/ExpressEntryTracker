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
