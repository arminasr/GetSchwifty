//
//  ConferencesListViewModel.swift
//  SwiftConferences
//
//  Created by Arminas on 2019-10-02.
//  Copyright © 2019 Arminas. All rights reserved.
//

import Foundation
import SwiftConferencesDataKit

struct ConferencesListViewModel {
    struct Section {
        let sectionName: String
        let cards: [ConferenceCardViewModel]
    }
    
    let conferences: [SwiftConference]
    let dataSource: [Section] = []
    
    init(conferences: [SwiftConference]) {
        self.conferences = conferences
    }
    
}

