//
//  File.swift
//  
//
//  Created by Arminas on 2019-10-21.
//

import Foundation

class UserDefaultsSwiftConferencesDataStore: LocalConferencesDataStore {
    private let stored = UserDefaults.standard
    private let recordsKey = "UserDefaultsConferenceRecords"
    private let favouriteRecordsKey = "UserDefaultsFavouriteConferenceRecords"
    
    func getSwiftConferences() -> [Conference]? {
        guard let data = stored.value(forKey: recordsKey) as? Data else {
            return nil
        }
        return try? PropertyListDecoder().decode([Conference].self, from: data)
    }
    
    func updateSwiftConferences(_ conferences: [Conference]) {
        if let data = try? PropertyListEncoder().encode(conferences) {
            stored.set(data, forKey: recordsKey)
        }
    }
    
    func getFavouriteSwiftConferences() -> [Conference]? {
        guard let data = stored.value(forKey: favouriteRecordsKey) as? Data else {
            return nil
        }
        return try? PropertyListDecoder().decode([Conference].self, from: data)
    }
    
    func updateFavouriteSwiftConferences(_ conferences: [Conference]) {
        if let data = try? PropertyListEncoder().encode(conferences) {
            stored.set(data, forKey: favouriteRecordsKey)
        }
    }
}
