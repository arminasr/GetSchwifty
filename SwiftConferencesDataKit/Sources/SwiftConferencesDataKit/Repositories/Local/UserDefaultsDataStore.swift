//
//  File.swift
//  
//
//  Created by Arminas on 2019-10-21.
//

import Foundation
import Combine

class UserDefaultsDataStore: LocalDataStore {
    private let stored = UserDefaults.standard
    private let recordsKey = "UserDefaultsConferenceRecords"
    
    func conferencesPublisher() -> AnyPublisher<[Conference], Never> {
        guard let data = stored.value(forKey: recordsKey) as? Data else {
            return Just([]).eraseToAnyPublisher()
        }
        guard let conferences = try? PropertyListDecoder().decode([Conference].self, from: data) else {
            return Just([]).eraseToAnyPublisher()
        }
        return Just(conferences).eraseToAnyPublisher()
    }
    
    func updateConferences(_ conferences: [Conference]) {
        guard !conferences.isEmpty else {
            return
        }
        if let data = try? PropertyListEncoder().encode(conferences) {
            stored.set(data, forKey: recordsKey)
        }
    }
}
