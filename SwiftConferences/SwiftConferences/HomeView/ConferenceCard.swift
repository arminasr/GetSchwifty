//
//  ConferenceCard.swift
//  SwiftConferences
//
//  Created by Arminas on 2019-09-25.
//  Copyright © 2019 Arminas. All rights reserved.
//

import SwiftUI

struct ConferenceCard: View {
    
    @State var cardViewModel: ConferenceCardViewModel
    
    var body: some View {
        VStack {
            HStack() {
                Text("\(cardViewModel.conferenceName)").font(.title).lineLimit(nil)
                Spacer()
            }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
            
            HStack {
                Text("\(cardViewModel.conferenceDate)").font(.headline)
                Spacer()
            }
            HStack {
                Text("\(cardViewModel.location)").font(.footnote)
                Spacer()
            }
            HStack {
                Button(action: {
                    print("Favourites")
                }) {
                    Image(systemName: "globe").foregroundColor(Color("Electric"))
                }
                .padding()
                Button(action: {
                    print("Favourites")
                }) {
                    Image(systemName: "star").foregroundColor(Color("Electric"))
                }
                .padding()
                Button(action: {
                    print("Favourites")
                }) {
                    Image(systemName: "pencil.circle").foregroundColor(Color("Electric"))
                }
                .padding()
            }
        }
        .padding()
        .background(Color("CardBackgroungColor"))
        
        .cornerRadius(30)
    }
}
