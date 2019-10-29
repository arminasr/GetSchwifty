//
//  ContentView.swift
//  SwiftConferences
//
//  Created by Arminas on 2019-09-25.
//  Copyright © 2019 Arminas. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject private var viewModel: HomeViewModel
    @ObservedObject private var viewModelDTO: HomeViewModel.HomeViewModelDTO
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        self.viewModelDTO = viewModel.viewModelDTO
    }
    
    var body: some View {
        ZStack {
            ActivityIndicator(isAnimating: $viewModel.viewModelDTO.isLoading, style: .large)
            NavigationView {
                ConferencesList(viewModel: viewModel.viewModelDTO.conferencesListViewModel)
                    .navigationBarItems(trailing: Button(action: {
                        guard self.viewModel.mode == .all else {
                            self.viewModel.mode = .all
                            return
                        }
                        self.viewModel.mode = .favourite
                    }) {
                        Image(systemName: viewModel.viewModelDTO.favouriteIconName)
                            .resizable()
                            .frame(width: 22, height: 22)
                    })
                    .navigationBarTitle(Text("\(viewModel.viewModelDTO.navigationBarTitle)"))
            }
        }
    }
}
