//
//  Webview.swift
//  DesignSystem
//
//  Created by Charles Lima on 2024-04-18.
//

import WebKit
import SwiftUI

public struct WebView: UIViewRepresentable {
 
    var url: String
    private let webView: WKWebView
    
    public init(url: String) {
        webView = WKWebView(frame: .zero)
        self.url = url
    }
    
    public func makeUIView(context: Context) -> WKWebView {
        return webView
    }
    
    public func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let url = URL(string: url) else { return }
        webView.load(URLRequest(url: url))
    }
}
