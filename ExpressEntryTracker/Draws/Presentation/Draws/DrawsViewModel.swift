//
//  DrawsViewModel.swift
//  ExpressEntryTracker
//
//  Created by Charles Lima on 2024-04-17.
//
import SwiftUI
import Utilities

enum DrawsViewMode: Int, CaseIterable, Identifiable {
    var id: Int { self.rawValue }
    
    case rounds = 0
    case pool = 1
    
    var title: String {
        switch self {
        case .rounds:
            "Rounds"
        case .pool:
            "Pool"
        }
    }
}

protocol IDrawsViewModel {
    var filter: String? { get set }
    var filterOptions: [String?] { get }
    var state: ViewState<[Draw]> { get }
    var viewMode: DrawsViewMode { get set }
    func fetch() async
    func refresh() async
    func poolTitle(date: Date) -> String
    func history(for range: ScoreRange) -> PoolHistory
}

@Observable class DrawsViewModel: IDrawsViewModel {
    
    private let dateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter
    }()
    
    let listDrawUseCase: IListDrawUseCase
    var state: ViewState<[Draw]> = .loading
    var viewMode: DrawsViewMode = .rounds
    
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
    
    func poolTitle(date: Date) -> String {
        "CRS score distribution of candidates in the Express Entry pool as of \(dateFormatter.string(from: date))"
    }
    
    func history(for range: ScoreRange) -> PoolHistory {
        let pools = self.draws.compactMap({ draw -> (Date, Int)? in
            if let pool = draw.pool.first(where: { pool in pool.range == range }),
            let candidates = Int(pool.candidates) {
                return (draw.drawDistributionAsOn, candidates)
            }
            return nil
        })
        let marks = pools.compactMap { date, candidates in
            return candidates > 0 ? PoolHistory.Mark(date: date, candidates: candidates) : nil
        }
        return PoolHistory(range: range, history: Array(Set(marks)).sorted(by: { $0.date > $1.date }))
    }
    
}