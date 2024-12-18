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
        drawsView.tableView.delegate = self.tableDataSource
        drawsView.tableView.dataSource = self.tableDataSource
        drawsView.tableView.separatorStyle = .none
    }
    
    fileprivate func updateState(_ state: ViewState<[Draw]>) {
        self.drawsView.refreshControl.endRefreshing()
        switch state {
        case .loading:
            self.tableDataSource = LoadingDrawsDataSource()
            self.drawsView.segmentedControl.isHidden = true
            self.drawsView.hideErrorState()
        case .loaded(let draws):
            self.drawsView.segmentedControl.isHidden = false
            self.tableDataSource = LoadedDrawsDataSource(
                draws: draws, mode: viewModel.viewMode,
                didSelectDraw: { [weak self] draw in
                    self?.navigationController?.pushViewController(DrawDetailsViewController(draw: draw), animated: true)
                }, didSelectPool: { [weak self] pool in
                    guard let self else { return }
                    let poolDetailVC = UIHostingController(rootView: PoolDetail(viewModel: PoolDetailViewModel(poolHistory: self.viewModel.history(for: pool.range))))
                    self.navigationController?.pushViewController(poolDetailVC, animated: true)
                })
            self.drawsView.hideErrorState()
        case .error:
            self.tableDataSource = EmptyDrawsDataSource()
            self.drawsView.showErrorState()
        }
        
        setupTableView()
    }
    
    private func setupBindings() {
        self.viewModel.state
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                self?.updateState(state)
                self?.setupTitle(for: state)
                self?.drawsView.tableView.reloadData()
            }.store(in: &cancellables)
        
        self.drawsView.segmentedControl.addTarget(self, action: #selector(didChangeSegment), for: .valueChanged)
        
        self.drawsView.retryButton.addTarget(self, action: #selector(didTapRetry), for: .touchUpInside)
        
        self.drawsView.tableView.refreshControl?.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
    }
    
    @objc private func didChangeSegment() {
        self.viewModel.viewMode = DrawsViewMode.allCases[self.drawsView.segmentedControl.selectedSegmentIndex]
        self.updateState(viewModel.state.value)
        self.drawsView.tableView.reloadData()
    }
    
    @objc private func didTapRetry() {
        Task {
            await viewModel.fetch()
        }
    }
    
    @objc private func didPullToRefresh() {
        Task {
            await self.viewModel.refresh()
        }
    }
    
}

extension DrawsViewController: UITableViewDelegate {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableDataSource?.tableView(tableView, numberOfRowsInSection: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableDataSource?.tableView?(tableView, didSelectRowAt: indexPath)
    }
}

extension DrawsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableDataSource?.tableView(tableView, cellForRowAt: indexPath) ?? UITableViewCell()
    }
}
