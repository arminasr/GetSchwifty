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
        let isActive: Bool
        var link: URL? = nil
    }
    
    private let swiftConference: SwiftConference
    
    init(swiftConference: SwiftConference) {
        self.swiftConference = swiftConference
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
        return [websiteButtonModel, favouritesButtonModel, cfpButtonModel].compactMap{ $0 }
    }
    
    private var websiteButtonModel: ActionButtonModel? {
        guard let link = swiftConference.link else {
            return nil
        }
        return ActionButtonModel(icon: Image(systemName: "globe"),
                                 text: "Website",
                                 isActive: true,
                                 link: link)
    }
    
    private var favouritesButtonModel: ActionButtonModel? {
        guard swiftConference.link != nil else {
            return nil
        }
        let image = isFavourite ? Image(systemName: "start") : Image(systemName: "star.fill")
        let text = isFavourite ? "Favourite" : "Unfavourite"
        return ActionButtonModel(icon: image,
                                 text: text,
                                 isActive: true)
    }
    
    private var cfpButtonModel: ActionButtonModel? {
        let image = Image(systemName: "pencil.circle")
        guard let cfp = swiftConference.cfp else {
            return ActionButtonModel(icon: image,
                                     text: "See website for details",
                                     isActive: false)
        }
        guard cfp.containsLink && cfp.containsDeadline else {
            if cfp.containsLink {
                return ActionButtonModel(icon: image,
                                         text: "Deadline not specified",
                                         isActive: true,
                                         link: cfp.link)
            }
            if let deadline = cfp.deadline {
                return ActionButtonModel(icon: image,
                                         text: "Deadline \(DateFormatter().string(from: deadline)). See website for details",
                                         isActive: false)
            }
            return nil
        }
        return nil
    }
    
    private var isFavourite: Bool {
        return false
    }
}
