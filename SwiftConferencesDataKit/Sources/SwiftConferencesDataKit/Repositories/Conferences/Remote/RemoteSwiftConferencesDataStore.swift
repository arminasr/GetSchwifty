//
//  File.swift
//  
//
//  Created by Arminas on 2019-09-28.
//

import Foundation
import Combine

public enum RemoteSwiftConferencesDataStoreError: Error {
    case decodingError(Error)
    case urlError(String)
    case fetchingError(String)
}

@available(iOS 13.0, *)
protocol RemoteSwiftConferencesDataStore {
    func getSwiftConferences() -> AnyPublisher<[SwiftConference], RemoteSwiftConferencesDataStoreError>
}
