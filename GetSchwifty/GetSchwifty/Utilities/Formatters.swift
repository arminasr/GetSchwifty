//
//  Formatters.swift
//  GetSchwifty
//
//  Created by Arminas on 2019-10-01.
//  Copyright © 2019 Arminas. All rights reserved.
//

import Foundation

let conferenceIntervalFormatter: DateIntervalFormatter = {
  let formatter = DateIntervalFormatter()
  formatter.locale = .current
  formatter.dateTemplate = "MMMdy"
  return formatter
}()

let deadlineFormatter = { () -> DateFormatter in
    let formatter = DateFormatter()
    formatter.timeZone = .current
    formatter.locale = .current
    formatter.dateStyle = .short
    return formatter
}
