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
    var displayFilter: Bool { get }
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
    
    var displayFilter: Bool {
        self.viewMode == .rounds
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
        var dict = [Date: Int]()
        self.draws.forEach { draw in
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
