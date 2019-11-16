//
//  ConferencesList.swift
//  GetSchwifty
//
//  Created by Arminas on 2019-09-28.
//  Copyright © 2019 Arminas. All rights reserved.
//

import SwiftUI

struct ConferencesList: View {
    
    @ObservedObject var viewModel: ConferencesListViewModel
    
    init(viewModel: ConferencesListViewModel) {
        UITableView.appearance().separatorStyle = .none
        self.viewModel = viewModel
    }
    
    var body: some View {
        List {
            if !viewModel.emptyListMessage.isEmpty {
                Text("\(viewModel.emptyListMessage)").font(.caption)
            }
            ForEach(viewModel.conferencesListSections) { section in
                Section(header: Text("\(section.sectionName)")
                        .font(.headline)
                        .padding()) {
                    ForEach(section.cards) { cardViewModel in
                        ConferenceCard(cardViewModel: cardViewModel)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 12, trailing: 0))
                    }
                }
            }
        }
    }
}
