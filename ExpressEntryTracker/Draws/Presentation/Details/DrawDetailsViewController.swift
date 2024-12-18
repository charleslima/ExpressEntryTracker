//
//  DrawDetailsViewController.swift
//  ExpressEntryTracker
//
//  Created by Charles Lima on 2024-12-18.
//

import UIKit
import WebKit

class DrawDetailsViewController: UIViewController {
    
    private let webView = WKWebView()
    private let draw: Draw

    init(draw: Draw) {
        self.draw = draw
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = draw.drawName
        self.setView(newView: webView)
        self.loadWebView()
    }
    
    func loadWebView() {
        guard let url = URL(string: draw.drawNumberURL) else { return }
        webView.load(URLRequest(url: url))
    }
    
}
