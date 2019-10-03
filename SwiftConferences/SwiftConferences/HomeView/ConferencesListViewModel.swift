//
//  ConferencesListViewModel.swift
//  SwiftConferences
//
//  Created by Arminas on 2019-10-02.
//  Copyright © 2019 Arminas. All rights reserved.
//

import Foundation
import SwiftConferencesDataKit
import SwiftUI
import Combine

class ConferencesListViewModel: ObservableObject {
    struct Section: Identifiable {
        var id: ObjectIdentifier

        let sectionName: String
        let cards: [ConferenceCardViewModel]
    }
    
    @Published var dataSource: [ConferencesListViewModel.Section] = []
    
    init(conferences: [SwiftConference]) {
        dataSource = mapToSections(conferences: conferences)
    }
    
    func mapToSections(conferences: [SwiftConference]) -> [Section] {
        return [getUpcommingConferencesSection(from: conferences), getPastConferencesSection(from: conferences)]
    }
    
    private func getUpcommingConferencesSection(from conferences: [SwiftConference]) -> Section {
        return Section(sectionName: "Upcomming",
                       cards: conferences
                        .filter {
                            guard let endDate = $0.end else {
                                guard let startDate = $0.start else {
                                    //TBA
                                    return true
                                }
                                return startDate < Date() ? true : false
                            }
                            return endDate < Date() ? true : false
                       }
                       .map(ConferenceCardViewModel.init))
    }
    
    private func getPastConferencesSection(from conferences: [SwiftConference]) -> Section {
        return Section(sectionName: "Past",
                       cards: conferences
                        .filter {
                            guard let endDate = $0.end else {
                                guard let startDate = $0.start else {
                                    //TBA
                                    return false
                                }
                                return startDate < Date() ? false : true
                            }
                            return endDate < Date() ? false : true
                       }
                       .map(ConferenceCardViewModel.init))
    }
}

