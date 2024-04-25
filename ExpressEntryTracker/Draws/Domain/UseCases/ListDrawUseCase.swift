//
//  ListDrawUseCase.swift
//  ExpressEntryTracker
//
//  Created by Charles Lima on 2024-04-18.
//

import API
import Foundation

protocol IListDrawUseCase {
    func execute() async throws -> [Draw]
}

class ListDrawUseCase: IListDrawUseCase {
    
    let repository: IDrawRepository
    
    init(repository: IDrawRepository = DrawRepository()) {
        self.repository = repository
    }
    
    func execute() async throws -> [Draw] {
        let draws = try await repository.draws()
        return draws.map({
            Draw(drawNumber: $0.drawNumber,
                 drawNumberURL: $0.drawNumberURL,
                 drawDate: $0.drawDate,
                 drawDateFull: $0.drawDateFull,
                 drawName: $0.drawName,
                 drawSize: $0.drawSize,
                 drawCRS: $0.drawCRS,
                 drawCutOff: $0.drawCutOff,
                 drawDistributionAsOn: $0.drawDistributionAsOn,
                 pool: extractPool(from: $0))}
        )
    }
    
    private func extractPool(from draw: API.Draw) -> [ScorePool] {
        return ScoreRange.allCases.map { range in
            switch range {
            case .dd1: ScorePool(range: range, candidates: draw.dd1)
            case .dd2: ScorePool(range: range, candidates: draw.dd2)
            case .dd3: ScorePool(range: range, candidates: draw.dd3)
            case .dd4: ScorePool(range: range, candidates: draw.dd4)
            case .dd5: ScorePool(range: range, candidates: draw.dd5)
            case .dd6: ScorePool(range: range, candidates: draw.dd6)
            case .dd7: ScorePool(range: range, candidates: draw.dd7)
            case .dd8: ScorePool(range: range, candidates: draw.dd8)
            case .dd9: ScorePool(range: range, candidates: draw.dd9)
            case .dd10: ScorePool(range: range, candidates: draw.dd10)
            case .dd11: ScorePool(range: range, candidates: draw.dd11)
            case .dd12: ScorePool(range: range, candidates: draw.dd12)
            case .dd13: ScorePool(range: range, candidates: draw.dd13)
            case .dd14: ScorePool(range: range, candidates: draw.dd14)
            case .dd15: ScorePool(range: range, candidates: draw.dd15)
            case .dd16: ScorePool(range: range, candidates: draw.dd16)
            case .dd17: ScorePool(range: range, candidates: draw.dd17)
            case .dd18: ScorePool(range: range, candidates: draw.dd18)
            }
        }
    }
}
