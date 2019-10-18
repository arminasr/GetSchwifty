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
