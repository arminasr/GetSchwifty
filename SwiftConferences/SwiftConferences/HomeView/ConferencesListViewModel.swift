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
    
    @Published var dataSource: [ConferencesListViewModel.Section] = []
    
    private var conferences: [SwiftConference] {
        didSet {
            dataSource = mapToSections(conferences: conferences)
        }
    }
    
    init(conferences: [SwiftConference]) {
        self.conferences = conferences
    }
    
    func mapToSections(conferences: [SwiftConference]) -> [Section] {
        return [getUpcommingConferencesSection(from: conferences), getPastConferencesSection(from: conferences)]
    }
    
    private func getUpcommingConferencesSection(from conferences: [SwiftConference]) -> Section {
        let section = Section()
        section.sectionName = "Past"
        section.cards = conferences
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
            .map(ConferenceCardViewModel.init)

        return section
    }

    private func getPastConferencesSection(from conferences: [SwiftConference]) -> Section {
        let section = Section()
        section.sectionName = "Past"
        section.cards = conferences
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
            .map(ConferenceCardViewModel.init)
        return section
    }
}

extension ConferencesListViewModel {
    class Section: ObservableObject, Identifiable {
        let id = UUID()
        var sectionName: String = ""
        var cards: [ConferenceCardViewModel] = []
    }
}

