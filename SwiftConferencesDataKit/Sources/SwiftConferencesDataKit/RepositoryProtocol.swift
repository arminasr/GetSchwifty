//
//  File.swift
//  
//
//  Created by Arminas on 2019-10-10.
//

import Foundation
import Combine

public enum RepositoryError: Error {
    case networkError(String)
}

@available(iOS 13.0, *)
public protocol RepositoryProtocol {
    var conferencesPublisher: AnyPublisher<[Conference], Never> { get }
    var repositoryErrorPublisher: AnyPublisher<RepositoryError, Never> { get }
    func reload()
}
