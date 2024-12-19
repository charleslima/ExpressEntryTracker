//
//  LoadedDrawsDataSource.swift
//  ExpressEntryTracker
//
//  Created by Charles Lima on 2024-12-18.
//
import UIKit
import SwiftUI

class LoadedDrawsDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    private let draws: [Draw]
    private let mode: DrawsViewMode
    private let didSelectDraw: (Draw) -> Void
    private let didSelectPool: (ScorePool) -> Void
    
    private let dateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter
    }()
    
    init(draws: [Draw],
         mode: DrawsViewMode,
         didSelectDraw: @escaping (Draw) -> Void,
         didSelectPool: @escaping (ScorePool) -> Void
    ) {
        self.draws = draws
        self.didSelectDraw = didSelectDraw
        self.didSelectPool = didSelectPool
        self.mode = mode
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch mode {
        case .rounds:
            return self.draws.count
        case .pool:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch mode {
        case .rounds:
            let drawCell = tableView.dequeueReusableCell(withIdentifier: DrawItemView.className) as! DrawItemView
            drawCell.setData(draws[indexPath.row])
            return drawCell
        case .pool:
            return poolCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch mode {
        case .rounds:
            self.didSelectDraw(draws[indexPath.row])
        case .pool:
            break
        }
    }
    
    private func poolCell() -> UITableViewCell {
        let cell = UITableViewCell()
        cell.selectionStyle = .none
        if let draw = draws.first {
            cell.contentConfiguration = UIHostingConfiguration(content: {
                
                Text(poolTitle(date: draw.drawDistributionAsOn))
                    .multilineTextAlignment(.center)
                    .font(.title3)
                    .frame(maxWidth: .infinity)
                    .padding()
                ForEach(draw.pool, id: \.range) { pool in
                    ZStack {
                        HStack {
                            Text(pool.range.rawValue)
                                .font(.headline)
                            Spacer()
                            Text(pool.candidates)
                                .font(.subheadline)
                        }
                    }
                    .onTapGesture { [weak self] in
                        self?.didSelectPool(pool)
                    }
                    .padding(.horizontal, 24)
                    .padding(.vertical, 4)
                }
                
            }).margins(.all, .zero)
        }
        return cell
    }
    
    private func poolTitle(date: Date) -> String {
        "CRS score distribution of candidates in the Express Entry pool as of \(dateFormatter.string(from: date))"
    }
}
