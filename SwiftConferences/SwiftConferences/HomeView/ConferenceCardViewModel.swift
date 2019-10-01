//
//  ConferenceCardViewModel.swift
//  SwiftConferences
//
//  Created by Arminas on 2019-10-01.
//  Copyright © 2019 Arminas. All rights reserved.
//

import UIKit
import SwiftUI
import SwiftConferencesDataKit

struct ConferenceCardViewModel {
    
    struct ActionButtonModel {
        let icon: Image
        let text: String
    }
    
    private let swiftConference: SwiftConference
    
    init(swiftConference: SwiftConference) {
        self.swiftConference = swiftConference
    }
    
    var isFavourite: Bool {
        return false
    }
    
    var conferenceName: String {
        return swiftConference.name
    }
    
    var conferenceDate: String {
        guard let startDate = swiftConference.start else {
            return "TBA"
        }
        guard let endDate = swiftConference.end else {
            return conferenceIntervalFormatter.string(from: startDate, to: startDate)
        }
        return conferenceIntervalFormatter.string(from: startDate, to: endDate)
    }
    
    var location: String {
        guard let location = swiftConference.location else {
            return "TBA"
        }
        return location
    }
    
    var actionButtons: [ActionButtonModel] {
        return [websiteButtonModel, favouritesButtonModel].compactMap{ $0 }
    }
    
    private var websiteButtonModel: ActionButtonModel? {
        guard swiftConference.link != nil else {
            return nil
        }
        let image = Image(systemName: "globe")
        return ActionButtonModel(icon: image, text: "Website")
    }
    
    private var favouritesButtonModel: ActionButtonModel? {
        guard swiftConference.link != nil else {
            return nil
        }
        let image = isFavourite ? Image(systemName: "start") : Image(systemName: "star.fill")
        let text = isFavourite ? "Favourite" : "Unfavourite"
        return ActionButtonModel(icon: image, text: text)
    }
    
    private var cfpButtonModel: ActionButtonModel? {
        guard let cfp = swiftConference.cfp else {
            return nil
        }
        let image = Image(systemName: "pencil.circle")
        return ActionButtonModel(icon: image, text: "CFP")
    }
}
