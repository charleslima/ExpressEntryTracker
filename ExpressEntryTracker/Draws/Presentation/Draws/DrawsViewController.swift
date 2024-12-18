//
//  DrawsViewController.swift
//  ExpressEntryTracker
//
//  Created by Charles Lima on 2024-12-18.
//
import UIKit
import SwiftUI

class DrawsViewController: UIHostingController<DrawsView> {

    
    let drawsView = DrawsView(viewModel: DrawsViewModel())
    
    init() {
        super.init(rootView: drawsView)
    }
    
    @MainActor @preconcurrency required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
