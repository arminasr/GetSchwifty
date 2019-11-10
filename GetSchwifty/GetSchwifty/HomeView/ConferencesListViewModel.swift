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
    
    @Published var conferencesListSections: [ConferencesListViewModel.Section] = []
    @Published var emptyListMessage = ""
    
    func reload(with conferences: [Conference]) {
        if conferences.isEmpty {
            emptyListMessage = "No conferences found."
        } else {
            emptyListMessage = ""
        }
        conferencesListSections = mapToSections(conferences: conferences)
    }
}

extension ConferencesListViewModel {
    class Section: ObservableObject, Identifiable {
        let id = UUID()
        var sectionName: String = ""
        var cards: [ConferenceCardViewModel] = []
    }
}

extension ConferencesListViewModel {
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
                return Date.midnight(of: endDate) >= Date.midnight(of: Date()) ? true : false
            }
            .sorted(by: {
                if let firstStart = $0.start, let secondStart = $1.start {
                    return firstStart < secondStart
                } else if let firstEnd = $0.end, let secondEnd = $1.end {
                    return firstEnd < secondEnd
                }
                return false
            })
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
                return Date.midnight(of: endDate) < Date.midnight(of: Date()) ? true : false
            }
            .sorted(by: {
                if let firstStart = $0.start, let secondStart = $1.start {
                    return firstStart > secondStart
                } else if let firstEnd = $0.end, let secondEnd = $1.end {
                    return firstEnd > secondEnd
                }
                return false
            })
            .map(ConferenceCardViewModel.init)

        return section
    }
}

