//
//  HomeViewFactory.swift
//  SwiftConferences
//
//  Created by Arminas on 2019-10-02.
//  Copyright © 2019 Arminas. All rights reserved.
//

import SwiftUI
import SwiftConferencesDataKit

struct ViewsFactory {
    static func homeView() -> some View {
        let viewModel = HomeViewModel(conferenceRepository: ConferenceRepository())
        return HomeView(viewModel: viewModel)
    }
    
    static func webView(url: URL) -> some View {
        return WebView(url: url)
    }
}
