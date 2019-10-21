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
    
    public init() {}
    
    private var disposables = Set<AnyCancellable>()
    private var remoteDataStore: RemoteConferencesDataStore {
        APISwiftConferencesDataStore(apiClient: BaseAPIClient(),
                                     baseURLString: "https://raw.githubusercontent.com/Lascorbe/CocoaConferences/master/_data/")
    }
    private var localDataStore: LocalConferencesDataStore {
        UserDefaultsSwiftConferencesDataStore()
    }
    
    public func conferencesPublisher() -> AnyPublisher<[Conference], RemoteSwiftConferencesDataStoreError> {
        guard let conferences = localDataStore.getSwiftConferences() else {
            //self.localDataStore.updateSwiftConferences(conferences)
            return remoteDataStore.getSwiftConferences()
        }

        return Publishers.Sequence.init(sequence: conferences).collect().eraseToAnyPublisher()
    }
}
