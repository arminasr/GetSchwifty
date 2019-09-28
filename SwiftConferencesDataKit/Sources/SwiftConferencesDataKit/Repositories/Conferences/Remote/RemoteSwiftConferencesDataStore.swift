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
}

@available(iOS 13.0, *)
protocol RemoteSwiftConferencesDataStore {
    func getConferences(from url: URL) -> Future<[SwiftConference], RemoteSwiftConferencesDataStoreError>
}
