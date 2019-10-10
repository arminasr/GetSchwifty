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
    static func makeHomeView(conferenceRepository: ConferenceRepositoryProtocol) -> some View {
        let viewModel = HomeViewModel(conferenceRepository: conferenceRepository)
        
        return HomeView(viewModel: viewModel)
    }
}
