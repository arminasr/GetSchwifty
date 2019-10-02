//
//  ConferencesNavigationBar.swift
//  SwiftConferences
//
//  Created by Arminas on 2019-09-28.
//  Copyright © 2019 Arminas. All rights reserved.
//

import SwiftUI

struct ConferencesNavigationBar: View {
    
    
    var body: some View {
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
    }
}

struct ConferencesNavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        ConferencesNavigationBar()
    }
}
