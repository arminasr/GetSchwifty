//
//  WebView.swift
//  SwiftConferences
//
//  Created by Arminas on 2019-10-20.
//  Copyright © 2019 Arminas. All rights reserved.
//

import UIKit
import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    typealias UIViewType = WKWebView
    
    let url: URL
    
    private var request: URLRequest {
      return URLRequest(url: url)
    }
    
    func makeUIView(context: Context) -> WKWebView  {
        let webView = WKWebView()
        webView.allowsBackForwardNavigationGestures = true
        
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(request)
    }
}
