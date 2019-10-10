//
//  ConferencesListViewModel.swift
//  SwiftConferences
//
//  Created by Arminas on 2019-10-02.
//  Copyright © 2019 Arminas. All rights reserved.
//

import Foundation
import SwiftConferencesDataKit
import Combine

class ConferencesListViewModel: ObservableObject {
    @Published var conferenceListSections: [ConferencesListViewModel.Section] = []
    @Published var conferences: [Conference] = [] {
        didSet {
            conferenceListSections = mapToSections(conferences: conferences)
        }
    }
    
    private func mapToSections(conferences: [Conference]) -> [Section] {
        return [getUpcommingConferencesSection(from: conferences), getPastConferencesSection(from: conferences)]
    }

    private func getUpcommingConferencesSection(from conferences: [Conference]) -> Section {
        let section = Section()
        section.sectionName = "Upcomming conferences"
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
    
    private func getPastConferencesSection(from conferences: [Conference]) -> Section {
        let section = Section()
        section.sectionName = "Past conferences"
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
}

extension ConferencesListViewModel {
    class Section: ObservableObject, Identifiable {
        let id = UUID()
        var sectionName: String = ""
        var cards: [ConferenceCardViewModel] = []
    }
}

