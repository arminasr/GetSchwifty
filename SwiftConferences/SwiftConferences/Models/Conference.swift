//
//  Conference.swift
//  SwiftConferences
//
//  Created by Arminas Ruzgas on 7/29/19.
//  Copyright © 2019 Arminas Ruzgas. All rights reserved.
//

import Foundation

struct Conference {
    let id: UUID = UUID()
    let twitterId: String = "arminas_r"
    let name: String = "NSSpain 2019"
    let startingDate: Date? = Date()
    let imageUrl: URL? = nil
}
