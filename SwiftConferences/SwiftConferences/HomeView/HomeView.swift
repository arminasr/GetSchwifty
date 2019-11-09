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
            NavigationView {
                ConferencesList(viewModel: viewModel.viewModelDTO.conferencesListViewModel)
                    .navigationBarItems(
                        trailing: Button(action: {
                            self.viewModel.reload()
                        }) {
                            Image(systemName: viewModel.viewModelDTO.reloadIconName)
                                .resizable()
                                .frame(width: 22, height: 22)
                        }
                    )
                    .navigationBarTitle(
                        Text("\(viewModel.viewModelDTO.navigationBarTitle)")
                )
            }
            ActivityIndicator(isAnimating: $viewModel.viewModelDTO.isLoading, style: .large)
        }
    }
}
