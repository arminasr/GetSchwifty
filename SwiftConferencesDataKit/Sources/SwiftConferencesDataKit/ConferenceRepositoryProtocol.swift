//
//  File.swift
//  
//
//  Created by Arminas on 2019-10-10.
//

import Foundation
import Combine

public enum ConferenceRepositoryError: Error {
    case networkError(String)
    case favouriteConferencesDecodingError
}

@available(iOS 13.0, *)
public protocol ConferenceRepositoryProtocol {
    var conferencesPublisher: PassthroughSubject<[Conference], ConferenceRepositoryError> { get }
    func reload()
    //func favouriteConferencesPublisher() -> AnyPublisher<[Conference], ConferenceRepositoryError>
}
