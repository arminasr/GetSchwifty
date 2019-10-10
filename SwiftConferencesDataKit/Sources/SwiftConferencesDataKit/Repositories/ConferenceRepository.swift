//
//  ConferenceRepository.swift
//  
//
//  Created by Arminas on 2019-10-10.
//

import Foundation
import Combine
import SwiftConferencesAPIKit

@available(iOS 13.0, *)
public class ConferenceRepository: ConferenceRepositoryProtocol {
    
    public init(){}
    
    private var remoteDataStore: RemoteConferencesDataStore {
        APISwiftConferencesDataStore(apiClient: BaseAPIClient(),
                                     baseURLString: "https://raw.githubusercontent.com/Lascorbe/CocoaConferences/master/_data/")
    }
    
    public func getConferences() -> AnyPublisher<[Conference], RemoteSwiftConferencesDataStoreError> {
        remoteDataStore.getSwiftConferences()
    }
}
