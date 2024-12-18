//
//  EmptyDrawsDataSource.swift
//  ExpressEntryTracker
//
//  Created by Charles Lima on 2024-12-18.
//

import UIKit

class EmptyDrawsDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
