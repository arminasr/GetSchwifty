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
        List {
            ForEach(viewModel.dataSource) { section in
                Section(header: Text("\(section.sectionName)")) {
                    ForEach(section.cards) { card in
                        ConferenceCard()
                    }
                }
            }

            .onAppear() {

            }
        }
    }
}

//struct ConferencesList_Previews: PreviewProvider {
//    static var previews: some View {
//        ConferencesList()
//    }
//}
