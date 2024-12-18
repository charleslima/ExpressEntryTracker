//
//  ContentView.swift
//  ExpressEntryTracker
//
//  Created by Charles Lima on 2024-04-17.
//

import UIKit
import Utilities

class DrawsView: UIView {
    
    lazy var refreshControl = UIRefreshControl()
    
    lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: DrawsViewMode.allCases.map({ $0.title }))
        segmentedControl.prepareForConstraints()
        segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
    }()
    
    private lazy var segmentedControlContainer = {
        let segmentedControlContainer = UIView()
        segmentedControlContainer.frame = .init(origin: .zero, size: .init(width: self.frame.width, height: 32))
        return segmentedControlContainer
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.prepareForConstraints()
        tableView.refreshControl = refreshControl
        return tableView
    }()
    
    // MARK: Error View
    
    private lazy var errorContainer: UIView = {
        let errorContainer = UIView()
        errorContainer.prepareForConstraints()
        errorContainer.backgroundColor = .white
        errorContainer.isHidden = true
        return errorContainer
    }()
    
    private lazy var errorStackView: UIStackView = {
        let errorStackView = UIStackView()
        errorStackView.prepareForConstraints()
        errorStackView.axis = .vertical
        errorStackView.spacing = 16
        errorStackView.alignment = .center
        return errorStackView
    }()
    
    private lazy var errorImageView: UIImageView = {
        let errorImageView = UIImageView()
        errorImageView.prepareForConstraints()
        errorImageView.image = UIImage(systemName: "exclamationmark.warninglight")
        return errorImageView
    }()
    
    private lazy var errorTitle: UILabel = {
        let errorTitle = UILabel()
        errorTitle.prepareForConstraints()
        errorTitle.text = "Oops! Something Went Wrong"
        errorTitle.font = .preferredFont(forTextStyle: .headline)
        errorTitle.textColor = .secondaryLabel
        errorTitle.textAlignment = .center
        return errorTitle
    }()
    
    private lazy var errorDescription: UILabel = {
        let errorDescription = UILabel()
        errorDescription.prepareForConstraints()
        errorDescription.text = "We're sorry, but an unexpected error occurred. Please try again later"
        errorDescription.font = .preferredFont(forTextStyle: .subheadline)
        errorDescription.textColor = .tertiaryLabel
        errorDescription.textAlignment = .center
        errorDescription.numberOfLines = 0
        return errorDescription
    }()
    
    lazy var retryButton: UIButton = {
        let retryButton = UIButton(configuration: .borderedProminent(), primaryAction: nil)
        retryButton.setTitle("Retry", for: .normal)
        retryButton.titleLabel?.font = .preferredFont(forTextStyle: .headline)
        return retryButton
    }()
    
    init() {
        super.init(frame: .zero)
        self.prepareForConstraints()
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.backgroundColor = .white
        self.addSubview(errorContainer)
        self.addSubview(tableView)
        self.segmentedControlContainer.addSubview(segmentedControl)
        self.errorContainer.addSubview(errorStackView)
        self.errorStackView.addArrangedSubview(errorImageView)
        self.errorStackView.addArrangedSubview(errorTitle)
        self.errorStackView.addArrangedSubview(errorDescription)
        self.errorStackView.addArrangedSubview(retryButton)
        
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            errorContainer.topAnchor.constraint(equalTo: self.topAnchor),
            errorContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            errorContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            errorContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            errorStackView.leadingAnchor.constraint(equalTo: self.errorContainer.leadingAnchor),
            errorStackView.trailingAnchor.constraint(equalTo: self.errorContainer.trailingAnchor),
            errorStackView.centerYAnchor.constraint(equalTo: self.errorContainer.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            errorImageView.heightAnchor.constraint(equalToConstant: 64),
            errorImageView.widthAnchor.constraint(equalTo: errorImageView.heightAnchor, multiplier: 1)
        ])
        
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: self.segmentedControlContainer.topAnchor),
            segmentedControl.leadingAnchor.constraint(equalTo: self.segmentedControlContainer.leadingAnchor, constant: 24),
            segmentedControl.trailingAnchor.constraint(equalTo: self.segmentedControlContainer.trailingAnchor, constant: -24),
            segmentedControl.bottomAnchor.constraint(equalTo: self.segmentedControlContainer.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
        
        self.tableView.tableHeaderView = segmentedControlContainer
    }
    
    func showErrorState() {
        self.tableView.isHidden = true
        self.errorContainer.isHidden = false
    }

    func hideErrorState() {
        self.tableView.isHidden = false
        self.errorContainer.isHidden = true
    }
}
