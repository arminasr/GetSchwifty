//
//  Conference.swift
//  
//
//  Created by Arminas on 2019-09-28.
//

import Foundation
import Combine

public struct Conference: Codable {
    public let name: String
    public let start: Date?
    public let end: Date?
    public let location: String?
    public let link: URL?
    public let cfp: CFP?
}

public struct CFP: Codable {
    public let link: URL?
    public let deadline: Date?
    
    public var containsLinkAndDeadline: Bool {
        containsLink && containsDeadline
    }
    
    public var containsLink: Bool {
        link != nil
    }
    
    public var containsDeadline: Bool {
        deadline != nil
    }
}
