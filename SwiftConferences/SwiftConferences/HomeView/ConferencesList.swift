//
//  ConferencesList.swift
//  SwiftConferences
//
//  Created by Arminas on 2019-09-28.
//  Copyright © 2019 Arminas. All rights reserved.
//

import SwiftUI

struct ConferencesList: View {
    
    @ObservedObject var viewModel: ConferencesListViewModel
    
    init(viewModel: ConferencesListViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView {
            ForEach(viewModel.conferencesListSections) { section in
                Section(header: Text("\(section.sectionName)")
                        .font(.headline)
                        .padding()) {
                    ForEach(section.cards) { cardViewModel in
                        ConferenceCard(cardViewModel: cardViewModel)
                            .padding()
                    }
                }
            }
        }
    }
}
