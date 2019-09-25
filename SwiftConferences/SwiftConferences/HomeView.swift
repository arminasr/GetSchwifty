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
        VStack {
            HStack{
                Text("Swift Conferences").font(.largeTitle)
                Spacer()
                Button(action: {}) {
                    Text("Favourites")
                }
            }
            HStack {
                Text("Upcoming")
                Text("Past")
                Spacer()
            }
            List {
                ConferenceCard()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
