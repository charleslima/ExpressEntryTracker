//
//  UIViewControllerExtension.swift
//  ExpressEntryTracker
//
//  Created by Charles Lima on 2024-12-18.
//

import UIKit

public extension UIViewController {
    
    func setView(newView: UIView) {
        newView.prepareForConstraints()
        self.view.addSubview(newView)
        NSLayoutConstraint.activate([
            newView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            newView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            newView.topAnchor.constraint(equalTo: self.view.topAnchor),
            newView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
}
