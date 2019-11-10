//
//  ConferenceCardViewModel.swift
//  SwiftConferences
//
//  Created by Arminas on 2019-10-01.
//  Copyright © 2019 Arminas. All rights reserved.
//

import UIKit
import SwiftConferencesDataKit

class ConferenceCardViewModel: Identifiable {
    
    private let conference: Conference
    
    init(conference: Conference) {
        self.conference = conference
    }
    
    let id = UUID()
    
    var conferenceName: String {
        return conference.name
    }
    
    var conferenceDate: String {
        guard let startDate = conference.start else {
            return "TBA"
        }
        guard let endDate = conference.end else {
            return conferenceIntervalFormatter.string(from: startDate, to: startDate)
        }
        return conferenceIntervalFormatter.string(from: startDate, to: endDate)
    }
    
    var location: String {
        guard let location = conference.location else {
            return "TBA"
        }
        return location
    }
    
    var actionButtons: [ActionButtonModel] {
        return [websiteButtonModel, cfpButtonModel].compactMap{ $0 }
    }
    
    private var websiteButtonModel: ActionButtonModel? {
        guard let link = conference.link else {
            return nil
        }
        return ActionButtonModel(id: .website,
                                 iconName: "globe",
                                 text: "Website",
                                 isActive: true,
                                 url: link)
    }
    
    private var cfpButtonModel: ActionButtonModel? {
        let iconName = "pencil.circle"
        guard let cfp = conference.cfp, cfp.containsLink || cfp.containsDeadline else {
            return ActionButtonModel(id: .cfp,
                                     iconName: iconName,
                                     text: "See website\nfor CFP details",
                                     isActive: false)
        }
        if cfp.containsLink && cfp.containsDeadline {
            return ActionButtonModel(id: .cfp,
                                     iconName: iconName,
                                     text: "CFP deadline \n\(deadlineFormatter().string(from: cfp.deadline!))",
                                     isActive: true,
                                     url: cfp.link)

        }
        if cfp.containsLink {
            return ActionButtonModel(id: .cfp,
                                     iconName: iconName,
                                     text: "CFP deadline\nnot specified",
                                     isActive: true,
                                     url: cfp.link)
        }
        return nil
    }
}

extension ConferenceCardViewModel {
    struct ActionButtonModel: Identifiable {
        
        enum ButtonType: Int {
            case website = 0
            case cfp = 1
        }
        
        let id: ButtonType
        let iconName: String
        let text: String
        let isActive: Bool
        var url: URL? = nil
    }
}
extension ConferenceCardViewModel.ActionButtonModel.ButtonType: Identifiable {
    var id: Int { rawValue }
}
