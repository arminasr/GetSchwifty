//
//  Date+Midnight.swift
//  SwiftConferences
//
//  Created by Arminas on 2019-10-12.
//  Copyright © 2019 Arminas. All rights reserved.
//

import Foundation

extension Date {
    static var todaysMidnight: Date {
        let now = Date()
        let sameTimeTomorrow = Calendar.current.date(byAdding: .day, value: 1, to: now)!
        return Calendar.current.startOfDay(for: sameTimeTomorrow)
    }
}
