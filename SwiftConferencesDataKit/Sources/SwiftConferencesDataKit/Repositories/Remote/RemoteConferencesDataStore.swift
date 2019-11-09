//
//  File.swift
//  
//
//  Created by Arminas on 2019-09-28.
//

import Foundation
import Combine

public enum RemoteSwiftConferencesDataStoreError: Error {
    case urlError
    case fetchingError
}

@available(iOS 13.0, *)
public protocol RemoteConferencesDataStore {
    func swiftConferencesPublisher() -> AnyPublisher<[Conference], RemoteSwiftConferencesDataStoreError>
}
