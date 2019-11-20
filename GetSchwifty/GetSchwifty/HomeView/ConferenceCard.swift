//
//  ConferenceCard.swift
//  GetSchwifty
//
//  Created by Arminas on 2019-09-25.
//  Copyright © 2019 Arminas. All rights reserved.
//

import SwiftUI

struct ConferenceCard: View {
    
    var cardViewModel: ConferenceCardViewModel
    @State private var showDetails = false
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Text("\(cardViewModel.conferenceName)")
                    .font(.title)
                    .foregroundColor(Color(.systemPink))
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
            if showDetails {
                ConferenceCardDetails(viewModel: cardViewModel)
            }
        }
        .padding()
        .background(LinearGradient(gradient: Gradient(colors: [Color(.systemPink).opacity(0.15), Color(.systemBlue).opacity(0.15)]), startPoint: .top, endPoint: .bottom))
        .cornerRadius(20)
        .buttonStyle(BorderlessButtonStyle())
        .accentColor(Color(.systemPink))
        .onTapGesture {
            self.showDetails.toggle()
        }
    }
}
