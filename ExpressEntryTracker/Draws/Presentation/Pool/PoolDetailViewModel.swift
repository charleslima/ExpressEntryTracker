//
//  PoolDetailViewModel.swift
//  ExpressEntryTracker
//
//  Created by Charles Lima on 2024-04-25.
//

import Foundation
import SwiftUI

protocol IPoolDetailViewModel {
    var poolHistory: PoolHistory { get }
    func dateString(for date: Date) -> String
}

@Observable class PoolDetailViewModel: IPoolDetailViewModel {
    
    private let dateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter
    }()
    
    let poolHistory: PoolHistory
    
    init(poolHistory: PoolHistory) {
        self.poolHistory = poolHistory
    }
    
    func dateString(for date: Date) -> String {
        dateFormatter.string(from: date)
    }
}
