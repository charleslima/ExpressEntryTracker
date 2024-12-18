//
//  DrawsViewController.swift
//  ExpressEntryTracker
//
//  Created by Charles Lima on 2024-12-18.
//
import UIKit
import SwiftUI
import Utilities
import Combine

class DrawsViewController: UIViewController {

    private let viewModel = DrawsViewModel()
    private let drawsView = DrawsView()
    private var cancellables = [AnyCancellable]()

    private var tableDataSource: (UITableViewDataSource & UITableViewDelegate)?
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @MainActor @preconcurrency required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.setView(newView: drawsView)
        setupTableView()
        setupBindings()
        Task {
            await self.viewModel.fetch()
        }
    }
    
    private func setupTitle(for state: ViewState<[Draw]>) {
        switch state {
        case .loading, .loaded:
            self.title = "Rounds"
        case .error:
            self.title = ""
        }
    }
    
    private func setupTableView() {
        drawsView.tableView.delegate = self
        drawsView.tableView.dataSource = self
        drawsView.tableView.separatorStyle = .none
    }
    
    fileprivate func updateState(_ state: ViewState<[Draw]>) {
        switch state {
        case .loading:
            self.tableDataSource = LoadingDrawsDataSource()
        case .loaded(let draws):
            self.tableDataSource = LoadedDrawsDataSource(draws: draws, mode: viewModel.viewMode)
        case .error:
            self.tableDataSource = LoadingDrawsDataSource()
        }
    }
    
    private func setupBindings() {
        self.viewModel.state.sink { [weak self] state in
            
            self?.updateState(state)
            
            DispatchQueue.main.async {
                self?.setupTitle(for: state)
                self?.drawsView.tableView.reloadData()
            }
            
        }.store(in: &cancellables)
        
        self.drawsView.segmentedControl.addTarget(self, action: #selector(didChangeSegment), for: .valueChanged)
    }
    
    @objc private func didChangeSegment() {
        self.viewModel.viewMode = DrawsViewMode.allCases[self.drawsView.segmentedControl.selectedSegmentIndex]
        self.updateState(viewModel.state.value)
        self.drawsView.tableView.reloadData()
    }
    
}

extension DrawsViewController: UITableViewDelegate {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableDataSource?.tableView(tableView, numberOfRowsInSection: section) ?? 0
    }
}

extension DrawsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableDataSource?.tableView(tableView, cellForRowAt: indexPath) ?? UITableViewCell()
    }
}

class LoadingDrawsDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.selectionStyle = .none
        cell.contentConfiguration = UIHostingConfiguration(content: {
            return DrawItemShimmerView()
        }).margins(.all, .zero)
        
        return cell
    }
}

class LoadedDrawsDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    private let draws: [Draw]
    private let mode: DrawsViewMode
    
    private let dateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter
    }()
    
    init(draws: [Draw], mode: DrawsViewMode) {
        self.draws = draws
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
        let cell = UITableViewCell()
        cell.selectionStyle = .none
        
        switch mode {
        case .rounds:
            cell.contentConfiguration = UIHostingConfiguration(content: {
                return DrawItemView.init(draw: draws[indexPath.row])
            }).margins(.all, .zero)
        case .pool:
            if let draw = draws.first {
                cell.contentConfiguration = UIHostingConfiguration(content: {
                    
                    Text(poolTitle(date: draw.drawDistributionAsOn))
                        .multilineTextAlignment(.center)
                        .font(.title3)
                        .frame(maxWidth: .infinity)
                        .padding()
                    ForEach(draw.pool, id: \.range) { pool in
                        ZStack {
//                            NavigationLink(viewModel.poolTitle(date: draw.drawDistributionAsOn), value: pool).opacity(0)
                            HStack {
                                Text(pool.range.rawValue)
                                    .font(.headline)
                                Spacer()
                                Text(pool.candidates)
                                    .font(.subheadline)
                            }
                        }
                        .padding(.horizontal, 24)
                        .padding(.vertical, 4)
                    }
                    
                }).margins(.all, .zero)
            }
        }
        
        return cell
    }
    
    func poolTitle(date: Date) -> String {
        "CRS score distribution of candidates in the Express Entry pool as of \(dateFormatter.string(from: date))"
    }
}
