//
//  GetPoolHistoryUseCase.swift
//  ExpressEntryTracker
//
//  Created by Charles Lima on 2024-12-01.
//

import Foundation

protocol IGetPoolHistoryUseCase {
    func execute(draws: [Draw], range: ScoreRange) -> PoolHistory
}

class GetPoolHistoryUseCase: IGetPoolHistoryUseCase {
    func execute(draws: [Draw], range: ScoreRange) -> PoolHistory {
        var dict = [Date: Int]()
        draws.forEach { draw in
            if let pool = draw.pool.first(where: { $0.range == range }) {
                dict[draw.drawDistributionAsOn] = Int(pool.candidates.replacingOccurrences(of: ",", with: ""))
            }
        }
        
        let marks = dict.keys.sorted().compactMap { date in
            if let candidates = dict[date], candidates > 0 {
                return PoolHistory.Mark(date: date, candidates: candidates)
            }
            return nil
        }

        return PoolHistory(range: range, history: marks)
    }
}
