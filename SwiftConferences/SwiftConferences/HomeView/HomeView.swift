//
//  ContentView.swift
//  SwiftConferences
//
//  Created by Arminas on 2019-09-25.
//  Copyright © 2019 Arminas. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    
    var viewModel: HomeViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                ConferencesList(viewModel: viewModel.viewModelDTO.conferencesListViewModel)
            }
            .navigationBarTitle(Text("\(viewModel.viewModelDTO.navigationBarTitle)"))
        }
    }
}
