//
//  HomeViewFactory.swift
//  GetSchwifty
//
//  Created by Arminas on 2019-10-02.
//  Copyright © 2019 Arminas. All rights reserved.
//

import SwiftUI
import SwiftConferencesDataKit

struct ViewsFactory {
    static func homeView() -> some View {
        let viewModel = HomeViewModel(conferenceRepository: Repository())
        return HomeView(viewModel: viewModel)
    }
    
    static func webView(url: URL) -> some View {
        return WebView(url: url)
    }
    
    static func infoView() -> some View {
        return InfoView()
    }
}
