//
//  LoadingDrawsDataSource.swift
//  ExpressEntryTracker
//
//  Created by Charles Lima on 2024-12-18.
//

import UIKit
import SwiftUI

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
