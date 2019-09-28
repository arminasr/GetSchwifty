//
//  SwiftConference.swift
//  
//
//  Created by Arminas on 2019-09-28.
//

import Foundation

public struct SwiftConference: Codable {
    let name: String
    let startDate: Date
    let endDate: Date
    let location: String
    let link: URL?
    let cfp: CFP?
}

public struct CFP: Codable {
    let link: URL?
    let deadline: Date?
}
