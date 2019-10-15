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
                    .foregroundColor(Color(.systemTeal))
                    .lineLimit(nil)
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
            
            HStack(alignment: .top, spacing: 44) {
                ForEach(cardViewModel.actionButtons) { buttonModel in
                    Button(action: {
                        print("Favourites")
                    }) {
                        VStack(alignment: .center) {
                            Image(systemName: buttonModel.iconName)
                                .resizable()
                                .frame(width: 30, height: 30)
                            Text("\(buttonModel.text)")
                                .lineLimit(2)
                                .font(.footnote)
                        }
                    }
                    .fixedSize()
                    .foregroundColor(Color(.systemTeal))
                    .disabled(!buttonModel.isActive)
                }
            }
            .padding()
            
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(30)
        .shadow(color: Color(.systemTeal), radius: 4, x: 0, y: 2)
    }
}
