//
//  File.swift
//  
//
//  Created by Arminas on 2019-10-10.
//

import Foundation
import Combine

public enum ConferenceRepositoryError: Error {
    case networkError(Error)
    case favouriteConferencesDecodingError
}

@available(iOS 13.0, *)
public protocol ConferenceRepositoryProtocol {
    func conferencesPublisher() -> Future<[Conference], ConferenceRepositoryError>
    func favouriteConferencesPublisher() -> Future<[Conference], ConferenceRepositoryError>
}
