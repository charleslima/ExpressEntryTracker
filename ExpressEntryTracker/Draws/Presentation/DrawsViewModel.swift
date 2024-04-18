//
//  DrawsViewModel.swift
//  ExpressEntryTracker
//
//  Created by Charles Lima on 2024-04-17.
//
import SwiftUI
import Utilities

protocol IDrawsViewModel {
    var state: ViewState<[Draw]> { get }
    func fetch() async
    func refresh() async
}

@Observable class DrawsViewModel: IDrawsViewModel {
    let listDrawUseCase: IListDrawUseCase

    var state: ViewState<[Draw]> = .loading
    
    init(listDrawUseCase: IListDrawUseCase = ListDrawUseCase()) {
        self.listDrawUseCase = listDrawUseCase
    }
    
    func refresh() async {
        await fetchDraws()
    }
    
    func fetch() async {
        state = .loading
        await fetchDraws()
    }

    private func fetchDraws() async {
        do {
            let draws = try await listDrawUseCase.execute()
            state = .loaded(draws)
        } catch {
            state = .error(error)
        }
    }
    
}
