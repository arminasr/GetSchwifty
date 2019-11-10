//
//  Date+Midnight.swift
//  SwiftConferences
//
//  Created by Arminas on 2019-10-12.
//  Copyright © 2019 Arminas. All rights reserved.
//

import Foundation

extension Date {
    static func midnight(of date: Date) -> Date {
        Calendar.current.startOfDay(for: date)
    }
}
