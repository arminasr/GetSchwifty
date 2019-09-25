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
            Text("SwiftAlps")
        }
        .background(Color.red)
        .cornerRadius(30)
    }
}

struct ConferenceCard_Previews: PreviewProvider {
    static var previews: some View {
        ConferenceCard()
    }
}
