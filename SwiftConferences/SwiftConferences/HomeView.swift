//
//  HomeView.swift
//  SwiftConferences
//
//  Created by Arminas Ruzgas on 7/29/19.
//  Copyright © 2019 Arminas Ruzgas. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    @State var selectedConference: Conference? = nil
    var conferences: [Conference] = [Conference(), Conference(), Conference(), Conference()]
    
    var body: some View {
        
        VStack {
            HeaderView(conference: $selectedConference)
            withAnimation {
                VStack {
                    
                    CategoryRow(title: "Upcoming conferences", selectedItem: $selectedConference, items: conferences)
                    CategoryRow(title: "I'm interested", selectedItem: $selectedConference, items: conferences)
                }
                .blur(radius: selectedConference == nil ? 0 : 30)
            }
        }
        .background(
                Image("swift-background")
                    .blur(radius: 30)
        )
    }
}


#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(selectedConference: nil)
    }
}
#endif
