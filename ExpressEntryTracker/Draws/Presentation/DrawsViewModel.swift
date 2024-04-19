//
//  DrawsViewModel.swift
//  ExpressEntryTracker
//
//  Created by Charles Lima on 2024-04-17.
//
import SwiftUI
import Utilities

protocol IDrawsViewModel {
    var filter: String? { get set }
    var filterOptions: [String?] { get }
    var state: ViewState<[Draw]> { get }
    func fetch() async
    func refresh() async
}

@Observable class DrawsViewModel: IDrawsViewModel {
    
    let listDrawUseCase: IListDrawUseCase
    var state: ViewState<[Draw]> = .loading
    
    var filter: String? = nil {
        didSet {
            let filteredDraws = if let filter {
                draws.filter({ $0.drawName == filter })
            } else {
                draws
            }
            state = .loaded(filteredDraws)
        }
    }
    
    var filterOptions: [String?] = []
    var draws: [Draw] = []
    
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
            self.draws = try await listDrawUseCase.execute()
            self.filterOptions = Array(Set(draws.map({ $0.drawName })))
            state = .loaded(draws)
        } catch {
            state = .error(error)
        }
    }
    
}
