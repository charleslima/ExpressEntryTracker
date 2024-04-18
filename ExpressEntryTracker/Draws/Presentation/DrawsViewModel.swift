//
//  DrawsViewModel.swift
//  ExpressEntryTracker
//
//  Created by Charles Lima on 2024-04-17.
//
import SwiftUI
import API
import Utilities

protocol IDrawsViewModel {
    var state: Result<[Draw], Error> { get }
    func fetchDraws() async
}

@Observable class DrawsViewModel: IDrawsViewModel {
    let repository: IDrawRepository

    var state: Result<[Draw], Error> = .success([])
    
    init(drawRepository: IDrawRepository = DrawRepository()) {
        self.repository = drawRepository
    }
    
    func fetchDraws() async {
        do {
            let draws = try await repository.draws()
            state = .success(draws)
        } catch {
            state = .failure(error)
        }
    }
}
