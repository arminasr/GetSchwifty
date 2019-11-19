//
//  ConferenceCardDetails.swift
//  GetSchwifty
//
//  Created by Arminas on 2019-11-19.
//  Copyright © 2019 Arminas. All rights reserved.
//

import SwiftUI

struct ConferenceCardDetails: View {
    
    let actionButtons: [ConferenceCardViewModel.ActionButtonModel]
    @State private var modalPresentationDetails: (isPresented: Bool, url: URL?) = (isPresented: false, url: nil)
    
    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 44) {
                ForEach(actionButtons) { buttonModel in
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
            MapView().frame(height: 200).cornerRadius(20)
        }
        .sheet(isPresented: $modalPresentationDetails.isPresented) {
            ViewsFactory.webView(url: self.modalPresentationDetails.url!)
        }
    }
}
