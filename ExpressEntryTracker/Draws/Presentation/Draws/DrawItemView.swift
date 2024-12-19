//
//  DrawItemView.swift
//  ExpressEntryTracker
//
//  Created by Charles Lima on 2024-04-17.
//

import UIKit

extension UIView {
    static var className: String { String(describing: Self.self) }
}

class DrawItemView: UITableViewCell {
    
    private var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.prepareForConstraints()
        stackView.axis = .horizontal
        return stackView
    }()
    
    private var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.prepareForConstraints()
        stackView.axis = .vertical
        return stackView
    }()
    
    private var detailsAlignmentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.prepareForConstraints()
        stackView.axis = .vertical
        stackView.alignment = .trailing
        return stackView
    }()
    
    private var detailsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.prepareForConstraints()
        stackView.axis = .vertical
        return stackView
    }()
    
    private var drawNumberLabel: UILabel = {
        let drawNumberLabel = UILabel()
        drawNumberLabel.prepareForConstraints()
        drawNumberLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        drawNumberLabel.textColor = .blue
        return drawNumberLabel
    }()
    
    private var drawNameLabel: UILabel = {
        let drawNameLabel = UILabel()
        drawNameLabel.prepareForConstraints()
        drawNameLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        return drawNameLabel
    }()
    
    private var drawDateLabel: UILabel = {
        let drawDateLabel = UILabel()
        drawDateLabel.prepareForConstraints()
        drawDateLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
        drawDateLabel.textColor = .gray
        return drawDateLabel
    }()
    
    private var drawScoreLabel: UILabel = {
        let drawScoreLabel = UILabel()
        drawScoreLabel.prepareForConstraints()
        drawScoreLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        drawScoreLabel.textColor = .white
        drawScoreLabel.textAlignment = .center
        drawScoreLabel.backgroundColor = .green
        drawScoreLabel.layer.cornerRadius = 20
        drawScoreLabel.layer.masksToBounds = true
        return drawScoreLabel
    }()
    
    private var drawSizeLabel: UILabel = {
        let drawSizeLabel = UILabel()
        drawSizeLabel.prepareForConstraints()
        drawSizeLabel.font = UIFont.preferredFont(forTextStyle: .caption2)
        drawSizeLabel.textColor = .gray
        drawSizeLabel.textAlignment = .center
        return drawSizeLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.contentView.addSubview(mainStackView)
        mainStackView.addArrangedSubview(contentStackView)
        mainStackView.addArrangedSubview(detailsAlignmentStackView)
        detailsAlignmentStackView.addArrangedSubview(detailsStackView)
        
        contentStackView.addArrangedSubview(self.drawNumberLabel)
        contentStackView.addArrangedSubview(self.drawNameLabel)
        contentStackView.addArrangedSubview(self.drawDateLabel)
        
        detailsStackView.addArrangedSubview(self.drawScoreLabel)
        detailsStackView.addArrangedSubview(self.drawSizeLabel)
    
    }
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
            mainStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 24),
            mainStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -24),
            mainStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            self.drawScoreLabel.widthAnchor.constraint(equalToConstant: 56),
            self.drawScoreLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func setData(_ draw: Draw) {
        self.drawNumberLabel.text = "#\(draw.drawNumber)"
        self.drawNameLabel.text = draw.drawName
        self.drawDateLabel.text = draw.drawDateFull
        
        self.drawScoreLabel.text = draw.drawCRS
        self.drawSizeLabel.text = draw.drawSize
    }
    
}
