//
//  HomeViewFactory.swift
//  SwiftConferences
//
//  Created by Arminas on 2019-10-02.
//  Copyright © 2019 Arminas. All rights reserved.
//

import SwiftUI
import SwiftConferencesDataKit

enum HomeViewFactory {
    static func makeHomeView(conferencesDataStore: SwiftConferencesDataKit.RemoteSwiftConferencesDataStore) -> some View {
        let viewModel = HomeViewModel(conferencesDataStore: conferencesDataStore)
        
        return HomeView(viewModel: viewModel)
    }
}
