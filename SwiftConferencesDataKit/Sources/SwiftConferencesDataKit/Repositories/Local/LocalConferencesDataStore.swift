//
//  File.swift
//  
//
//  Created by Arminas on 2019-10-21.
//

import Foundation
import Combine

@available(iOS 13.0, *)
public protocol LocalConferencesDataStore {
    func getSwiftConferences() -> [Conference]?
    func updateSwiftConferences(_ conferences: [Conference])
    
    func getFavouriteSwiftConferences() -> [Conference]?
    func updateFavouriteSwiftConferences(_ conferences: [Conference])
}
