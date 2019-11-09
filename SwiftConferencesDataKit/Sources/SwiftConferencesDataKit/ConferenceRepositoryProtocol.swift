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
}

@available(iOS 13.0, *)
public protocol ConferenceRepositoryProtocol {
    var conferencesPublisher: AnyPublisher<[Conference], Never> { get }
    var conferencesRepositoryErrorPublisher: AnyPublisher<ConferenceRepositoryError, Never> { get }
    func reload()
}
