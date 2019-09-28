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
                    HStack {
                        Button(action: {
                            print("Upcoming tapped")
                        }) {
                            Text("Upcoming")
                        }
                        Button(action: {
                            print("Past tapped")
                        }) {
                            Text("Past")
                        }
                        Spacer()
                        Button(action: {
                            print("Favourites")
                        }) {
                            Image(systemName: "star.fill")
                        }
                    }
                    .padding()
                    .font(.headline)
                    .accentColor(Color("Electric"))
                    List {
                        Section(header: Text("Upcoming")) {
                            ConferenceCard()
                        }
                        .onAppear() {
                        }
                        Section(header: Text("Past")) {
                            ConferenceCard()
                        }
                        .onAppear() {
                            print("Past appeared")
                        }
                    }
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
