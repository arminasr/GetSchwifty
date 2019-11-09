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
    
    public var conferencesPublisher: AnyPublisher<[Conference], Never>
    public var conferencesRepositoryErrorPublisher: AnyPublisher<ConferenceRepositoryError, Never>
    
    private var conferencesSubject = PassthroughSubject<[Conference], Never>()
    public var conferencesRepositoryErrorSubject = PassthroughSubject<ConferenceRepositoryError, Never>()
    
    private var disposables = Set<AnyCancellable>()
    private var remoteDataStore: RemoteConferencesDataStore {
        APISwiftConferencesDataStore(apiClient: BaseAPIClient(),
                                     baseURLString: "https://raw.githubusercontent.com/Lascorbe/CocoaConferences/master/_data/")
    }
    private var localDataStore: LocalConferencesDataStore {
        UserDefaultsSwiftConferencesDataStore()
    }
    
    
    public init() {
        conferencesPublisher = conferencesSubject.eraseToAnyPublisher()
        conferencesRepositoryErrorPublisher = conferencesRepositoryErrorSubject.eraseToAnyPublisher()
        reload()
    }
    
    public func reload() {
        localDataStore.swiftConferencesPublisher()
            .receive(on: DispatchQueue.main)
            .sink {
                $0.isEmpty ? self.refresh() : self.conferencesSubject.send($0)
                self.refresh()
            }
            .store(in: &disposables)
    }
    
    func refresh() {        
        remoteDataStore.swiftConferencesPublisher()
            .tryMap { conferences -> [Conference] in
                guard !conferences.isEmpty else {
                    throw RemoteSwiftConferencesDataStoreError.fetchingError
                }
                return conferences
            }
            .catch { error -> Just<[Conference]> in
                let networkError = ConferenceRepositoryError.networkError("Refreshing failed. Check internet connection. 💩")
                self.conferencesRepositoryErrorSubject.send(networkError)
                return Just([])
            }
            .sink {
                if !$0.isEmpty {
                    self.localDataStore.updateSwiftConferences($0)
                    self.conferencesSubject.send($0)
                }
            }
            .store(in: &disposables)
    }
}


