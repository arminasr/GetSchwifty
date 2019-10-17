//
//  HomeViewFactory.swift
//  SwiftConferences
//
//  Created by Arminas on 2019-10-02.
//  Copyright © 2019 Arminas. All rights reserved.
//

import SwiftUI
import SwiftConferencesDataKit
import WebKit

enum HomeViewFactory {
    static func makeHomeView(conferenceRepository: ConferenceRepositoryProtocol) -> some View {
        let viewModel = HomeViewModel(conferenceRepository: conferenceRepository)
        
        return HomeView(viewModel: viewModel)
    }
}

struct WebView: UIViewRepresentable {
    typealias UIViewType = WKWebView
    
    let url: URL
    
    var request: URLRequest {
      return URLRequest(url: url)
    }
    
    func makeUIView(context: Context) -> WKWebView  {
        let preferences = WKPreferences()

        
        let configuration = WKWebViewConfiguration()
        configuration.preferences = preferences
        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.allowsBackForwardNavigationGestures = true
        
        
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(request)
    }
}
