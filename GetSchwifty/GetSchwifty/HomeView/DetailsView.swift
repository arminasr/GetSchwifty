//
//  DetailsView.swift
//  GetSchwifty
//
//  Created by Arminas on 2019-11-20.
//  Copyright © 2019 Arminas. All rights reserved.
//

import SwiftUI

struct DetailsView: View {
    
    var cardViewModel: ConferenceCardViewModel
    
    var body: some View {
         ConferenceCardDetails(viewModel: cardViewModel)
            .padding()
            .background(LinearGradient(gradient: Gradient(colors: [Color(.systemPink).opacity(0.15), Color(.systemBlue).opacity(0.15)]), startPoint: .top, endPoint: .bottom))
            .cornerRadius(20)
            .padding()
            .accentColor(Color(.systemPink))
    }
}
