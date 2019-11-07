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
    func swiftConferencesPublisher() -> AnyPublisher<[Conference], Never>
    func updateSwiftConferences(_ conferences: [Conference])
    
    func favouriteSwiftConferencesPublisher() -> AnyPublisher<[Conference], Never>
    func updateFavouriteSwiftConferences(_ conferences: [Conference])
}
