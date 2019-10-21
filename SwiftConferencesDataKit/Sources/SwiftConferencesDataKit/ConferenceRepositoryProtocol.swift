//
//  File.swift
//  
//
//  Created by Arminas on 2019-10-10.
//

import Foundation
import Combine

@available(iOS 13.0, *)
public protocol ConferenceRepositoryProtocol {
    func conferencesPublisher() -> AnyPublisher<[Conference], RemoteSwiftConferencesDataStoreError> 
}
