//
//  ContentView.swift
//  SwiftConferences
//
//  Created by Arminas on 2019-09-25.
//  Copyright © 2019 Arminas. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel: HomeViewModel
    @State var isPresented = false

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            VStack {
                //ConferencesNavigationBar()
                ConferencesList(viewModel: viewModel.viewModelDTO.conferencesListViewModel)
            }
            .navigationBarTitle("\(viewModel.viewModelDTO.navigationBarTitle)")
        }
        .sheet(isPresented: $isPresented) {
            WebView(url: URL(string: "https://nsspain.com")!)
        }
    }
}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
//}
