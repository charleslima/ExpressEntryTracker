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
                 drawCutOff: $0.drawCutOff)}
        )
    }
}
