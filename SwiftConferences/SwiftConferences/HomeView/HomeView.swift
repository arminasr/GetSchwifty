//
//  ContentView.swift
//  SwiftConferences
//
//  Created by Arminas on 2019-09-25.
//  Copyright © 2019 Arminas. All rights reserved.
//

import SwiftUI

struct HomeView: View {
        var body: some View {
            NavigationView {
                VStack {
                    ConferencesNavigationBar()
                    ConferencesList()
                }
                .navigationBarTitle("Swift Conferences",
                                    displayMode: .large)
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}