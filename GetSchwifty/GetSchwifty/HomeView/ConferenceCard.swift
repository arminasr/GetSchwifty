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
    @State private var modalPresentationDetails: (isPresented: Bool, url: URL?) = (isPresented: false, url: nil)
    
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
            
            HStack(alignment: .top, spacing: 44) {
                ForEach(cardViewModel.actionButtons) { buttonModel in
                    Button(action: {
                        guard let url = buttonModel.url else {
                            return
                        }
                        self.modalPresentationDetails.url = url
                        self.modalPresentationDetails.isPresented.toggle()
                    }) {
                        VStack(alignment: .center) {
                            Group {
                                Image(systemName: buttonModel.iconName)
                                    .resizable()
                                    .frame(width: 22, height: 22)
                                Text("\(buttonModel.text)")
                                    .lineLimit(2)
                                    .multilineTextAlignment(.center)
                                    .font(.footnote)
                            }
                        }
                    }
                    .fixedSize()
                    .disabled(!buttonModel.isActive)
                }
            }
        }
        .sheet(isPresented: $modalPresentationDetails.isPresented) {
            ViewsFactory.webView(url: self.modalPresentationDetails.url!)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(30)
        .shadow(color: Color(.systemGray2), radius: 4, x: 0, y: 2)
        .buttonStyle(BorderlessButtonStyle())
        .accentColor(Color(.systemPink))
    }
}
