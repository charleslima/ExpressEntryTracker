//
//  PreviewPoolDetailViewModel.swift
//  ExpressEntryTracker
//
//  Created by Charles Lima on 2024-04-25.
//

import Foundation

class PreviewPoolDetailViewModel: IPoolDetailViewModel {
    
    private let dateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter
    }()
    
    static var poolHistory: PoolHistory = .init(range: .dd1, history: [
        PoolHistory.Mark(date: Date(), candidates: 1000),
        PoolHistory.Mark(date: Calendar.current.date(byAdding: .day, value: -15, to: Date())!, candidates: 2000),
        PoolHistory.Mark(date: Calendar.current.date(byAdding: .day, value: -30, to: Date())!, candidates: 3000),
        PoolHistory.Mark(date: Calendar.current.date(byAdding: .day, value: -45, to: Date())!, candidates: 4000),
        PoolHistory.Mark(date: Calendar.current.date(byAdding: .day, value: -60, to: Date())!, candidates: 5000)
    ])
    
    var poolHistory: PoolHistory = PreviewPoolDetailViewModel.poolHistory
    
    func dateString(for date: Date) -> String {
        dateFormatter.string(from: date)
    }
}
