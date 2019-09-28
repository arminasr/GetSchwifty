//
//  ConferencesList.swift
//  SwiftConferences
//
//  Created by Arminas on 2019-09-28.
//  Copyright © 2019 Arminas. All rights reserved.
//

import SwiftUI

struct ConferencesList: View {
    var body: some View {
        List {
            Section(header: Text("Upcoming")) {
                ConferenceCard()
            }
            .onAppear() {

            }
            Section(header: Text("Past")) {
                ConferenceCard()
            }
            .onAppear() {
                print("Past appeared")
            }
        }
    }
}

struct ConferencesList_Previews: PreviewProvider {
    static var previews: some View {
        ConferencesList()
    }
}
