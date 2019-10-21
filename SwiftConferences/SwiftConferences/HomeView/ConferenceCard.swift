//
//  ConferenceCard.swift
//  SwiftConferences
//
//  Created by Arminas on 2019-09-25.
//  Copyright © 2019 Arminas. All rights reserved.
//

import SwiftUI

struct ConferenceCard: View {
    
    var cardViewModel: ConferenceCardViewModel
    @State private var favouritesViewVisible = false
    @State private var modalPresentationDetails: (isPresented: Bool, url: URL?) = (isPresented: false, url: nil)
    
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
                        switch buttonModel.id {
                        case .website, .cfp:
                            guard let url = buttonModel.url else {
                                break
                            }
                            self.modalPresentationDetails.url = url
                            self.modalPresentationDetails.isPresented.toggle()
                        case .favourite:
                            self.favouritesViewVisible.toggle()
                        }
                    }) {
                        VStack(alignment: .center) {
                            Group {
                                Image(systemName: buttonModel.iconName)
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                Text("\(buttonModel.text)")
                                    .lineLimit(2)
                                    .multilineTextAlignment(.center)
                                    .font(.footnote)
                            }
                        }
                    }
                    .fixedSize()
                    .accentColor(Color(.systemTeal))
                    .disabled(!buttonModel.isActive)
                }
            }
            .padding()
        }
        .sheet(isPresented: $modalPresentationDetails.isPresented) {
            WebView(url: self.modalPresentationDetails.url!)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(30)
        .shadow(color: Color(.systemTeal), radius: 4, x: 0, y: 2)
    }
}
