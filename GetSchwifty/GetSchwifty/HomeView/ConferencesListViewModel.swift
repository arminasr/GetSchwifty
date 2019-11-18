//
//  ConferencesListViewModel.swift
//  GetSchwifty
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
    
    private let notificationsService = NotificationsService()
    
    func reload(with conferences: [Conference]) {
        if conferences.isEmpty {
            emptyListMessage = "No conferences found."
        } else {
            emptyListMessage = ""
        }
        conferencesListSections = mapToSections(conferences: conferences)
        scheduleNotification(conferences: conferences)
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
        return [upcommingConferencesSection(from: conferences), pastConferencesSection(from: conferences)]
    }

    private func upcommingConferencesSection(from conferences: [Conference]) -> Section {
        let section = Section()
        section.sectionName = "Upcomming conferences"
        section.cards = sortedUpcommingConferences(from: conferences)
            .map(ConferenceCardViewModel.init)
        return section
    }
    
    private func pastConferencesSection(from conferences: [Conference]) -> Section {
        let section = Section()
        section.sectionName = "Past conferences"
        section.cards = sortedPastConferences(from: conferences)
            .map(ConferenceCardViewModel.init)

        return section
    }
    
    private func sortedUpcommingConferences(from conferences: [Conference]) -> [Conference] {
        conferences.filter {
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
    }
    
    private func sortedPastConferences(from conferences: [Conference]) -> [Conference] {
        conferences.filter {
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
    }
}

extension ConferencesListViewModel {
    private func scheduleNotification(conferences: [Conference]) {
        guard let firstUpcommingConference = sortedUpcommingConferences(from: conferences).first else {
            return
        }
        notificationsService.scheduleNotification(with: .conferenceStarting, for: firstUpcommingConference)
    }
}

