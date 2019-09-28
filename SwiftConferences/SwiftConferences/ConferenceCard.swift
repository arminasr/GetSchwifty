//
//  ConferenceCard.swift
//  SwiftConferences
//
//  Created by Arminas on 2019-09-25.
//  Copyright © 2019 Arminas. All rights reserved.
//

import SwiftUI

struct ConferenceCard: View {
    var body: some View {
        VStack {
            Text("Swift Alps").font(.largeTitle).colorInvert()
            Text("November 28–29, 2019").font(.subheadline).colorInvert()
            Text("🇨🇭 Crans-Montana, Switzerland").font(.caption).colorInvert()
            HStack {
                Button(action: {
                    print("Favourites")
                }) {
                    Image(systemName: "globe").foregroundColor(Color("Electric"))
                }
                Button(action: {
                    print("Favourites")
                }) {
                    Image(systemName: "star").foregroundColor(Color("Electric"))
                }
                Button(action: {
                    print("Favourites")
                }) {
                    Image(systemName: "pencil.circle").foregroundColor(Color("Electric"))
                }
            }
        }
        .background(Color("CardBackgroungColor"))
        
        .cornerRadius(30)
    }
}

struct ConferenceCard_Previews: PreviewProvider {
    static var previews: some View {
        ConferenceCard()
    }
}
