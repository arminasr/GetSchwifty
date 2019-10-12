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
                Text("\(cardViewModel.conferenceName)")
                    .font(.title)
                    .lineLimit(nil)
                Spacer()
            }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
            
            HStack {
                Text("\(cardViewModel.conferenceDate)").font(.headline)
                .foregroundColor(Color("Electric"))
                Spacer()
            }
            HStack {
                Text("\(cardViewModel.location)").font(.footnote)
                .foregroundColor(Color("Electric"))
                Spacer()
            }
            
            HStack {
                ForEach(cardViewModel.actionButtons) { buttonModel in
                    VStack {
                        Button(action: {
                            print("Favourites")
                        }) {
                            buttonModel.icon
                        }
                        Text("\(buttonModel.text)").font(.footnote)
                    }
                    .padding()
                    .foregroundColor(Color("Electric"))
                }
            }
        }
        .padding()
        .background(Color("CardBackgroungColor"))
        .cornerRadius(30)
        .shadow(color: Color("Electric"), radius: 4, x: 0, y: 2)
    }
}
