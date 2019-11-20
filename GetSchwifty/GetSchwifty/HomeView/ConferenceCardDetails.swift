//
//  ConferenceCardDetails.swift
//  GetSchwifty
//
//  Created by Arminas on 2019-11-19.
//  Copyright © 2019 Arminas. All rights reserved.
//

import SwiftUI

struct ConferenceCardDetails: View {
    
    @ObservedObject var viewModel: ConferenceCardViewModel
    @State private var modalPresentationDetails: (isPresented: Bool, url: URL?) = (isPresented: false, url: nil)
    
    init(viewModel: ConferenceCardViewModel) {
        self.viewModel = viewModel
        self.viewModel.updateCoordinate()
    }
    
    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 44) {
                ForEach(viewModel.actionButtons) { buttonModel in
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
            }.transition(.scale)
            if viewModel.coordinate != nil {
                MapView(coordinate: viewModel.coordinate).frame(height: 250).transition(.opacity)
            }
        }
        .animation(.default)
        .sheet(isPresented: $modalPresentationDetails.isPresented) {
            ViewsFactory.webView(url: self.modalPresentationDetails.url!)
        }
    }
}
