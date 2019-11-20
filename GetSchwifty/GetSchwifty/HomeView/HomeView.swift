//
//  ContentView.swift
//  GetSchwifty
//
//  Created by Arminas on 2019-09-25.
//  Copyright © 2019 Arminas. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject private var viewModel: HomeViewModel
    @ObservedObject private var conferencesListViewModel: ConferencesListViewModel
    @State private var infoViewPresented: Bool = false
    @State private var detailsViewPresented: Bool = false
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        self.conferencesListViewModel = viewModel.conferencesListViewModel
    }
    
    private var conferenceCardViewModelForDetailsSelected: Bool {
        viewModel.conferencesListViewModel.conferenceCardViewModelForDetails != nil
    }
    
    var body: some View {
        ZStack {
            NavigationView {
                ConferencesList(viewModel: viewModel.conferencesListViewModel)
                    .navigationBarItems(
                        leading: Button(action: {
                            self.infoViewPresented.toggle()
                        }) {
                            Image(systemName: viewModel.infoIconName)
                                .resizable()
                                .frame(width: 22, height: 22)
                        },
                        trailing: Button(action: {
                            self.viewModel.reload()
                        }) {
                            Image(systemName: viewModel.reloadIconName)
                                .resizable()
                                .frame(width: 22, height: 22)
                        }
                        .sheet(isPresented: $infoViewPresented) {
                            ViewsFactory.infoView()
                        }
                    )
                    .navigationBarTitle(
                        Text("\(viewModel.navigationBarTitle)")
                    )
            }
            .accentColor(Color(.systemPink))
            .animation(nil)
            .blur(radius: conferenceCardViewModelForDetailsSelected ? 30 : 0)
            .animation(.easeOut)
            
            if conferenceCardViewModelForDetailsSelected  {
                Rectangle()
                    .background(Color.black)
                    .opacity(0.001)
                    .edgesIgnoringSafeArea(.all)
                    .animation(.easeIn)
                    .onTapGesture {
                        self.viewModel.conferencesListViewModel.conferenceCardViewModelForDetails = nil
                    }
            }
            
            if conferenceCardViewModelForDetailsSelected {
                DetailsView(cardViewModel: viewModel.conferencesListViewModel.conferenceCardViewModelForDetails!)
                    .onTapGesture {
                        self.viewModel.conferencesListViewModel.conferenceCardViewModelForDetails = nil
                    }
            }
            
            ActivityIndicator(isAnimating: $viewModel.isLoading, style: .large)
        }
    }
}
