//
//  DrawRepositoryMock.swift
//  ExpressEntryTracker
//
//  Created by Charles Lima on 2024-12-01.
//
import API

class DrawRepositoryMock: IDrawRepository {
    
    var mockResult: Result<[API.Draw], Error>?
    
    func draws() async throws -> [API.Draw] {
        if let result = mockResult {
            switch result {
            case .success(let draws):
                return draws
            case .failure(let error):
                throw error
            }
        }
        return []
    }
}
