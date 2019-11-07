//
//  File.swift
//  
//
//  Created by Arminas on 2019-10-21.
//

import Foundation
import Combine

class UserDefaultsSwiftConferencesDataStore: LocalConferencesDataStore {
    private let stored = UserDefaults.standard
    private let recordsKey = "UserDefaultsConferenceRecords"
    private let favouriteRecordsKey = "UserDefaultsFavouriteConferenceRecords"
    
    func swiftConferencesPublisher() -> AnyPublisher<[Conference], Never> {
        guard let data = stored.value(forKey: recordsKey) as? Data else {
            return Just([]).eraseToAnyPublisher()
        }
        guard let conferences = try? PropertyListDecoder().decode([Conference].self, from: data) else {
            return Just([]).eraseToAnyPublisher()
        }
        return Just(conferences).eraseToAnyPublisher()
    }
    
    func updateSwiftConferences(_ conferences: [Conference]) {
        guard !conferences.isEmpty else {
            return
        }
        if let data = try? PropertyListEncoder().encode(conferences) {
            stored.set(data, forKey: recordsKey)
        }
    }
    
    func favouriteSwiftConferencesPublisher() -> AnyPublisher<[Conference], Never> {
        guard let data = stored.value(forKey: favouriteRecordsKey) as? Data else {
            return Just([]).eraseToAnyPublisher()
        }
        guard let conferences = try? PropertyListDecoder().decode([Conference].self, from: data) else {
            return Just([]).eraseToAnyPublisher()
        }
        return Just(conferences).eraseToAnyPublisher()
    }
    
    func updateFavouriteSwiftConferences(_ conferences: [Conference]) {
        if let data = try? PropertyListEncoder().encode(conferences) {
            stored.set(data, forKey: favouriteRecordsKey)
        }
    }
}
