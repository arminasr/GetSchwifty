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
public class Repository: RepositoryProtocol {
    
    public var conferencesPublisher: AnyPublisher<[Conference], Never>
    public var repositoryErrorPublisher: AnyPublisher<RepositoryError, Never>
    
    private var conferencesSubject = PassthroughSubject<[Conference], Never>()
    public var conferencesRepositoryErrorSubject = PassthroughSubject<RepositoryError, Never>()
    
    private var disposables = Set<AnyCancellable>()
    private var remoteDataStore: RemoteDataStore {
        APIDataStore(apiClient: BaseAPIClient(),
                                     baseURLString: "https://raw.githubusercontent.com/Lascorbe/CocoaConferences/master/_data/")
    }
    private var localDataStore: LocalDataStore {
        UserDefaultsDataStore()
    }
    
    
    public init() {
        conferencesPublisher = conferencesSubject.eraseToAnyPublisher()
        repositoryErrorPublisher = conferencesRepositoryErrorSubject.eraseToAnyPublisher()
        reload()
    }
    
    public func reload() {
        localDataStore.conferencesPublisher()
            .receive(on: DispatchQueue.main)
            .sink {
                $0.isEmpty ? self.refresh() : self.conferencesSubject.send($0)
                self.refresh()
            }
            .store(in: &disposables)
    }
    
    func refresh() {        
        remoteDataStore.conferencesPublisher()
            .tryMap { conferences -> [Conference] in
                guard !conferences.isEmpty else {
                    throw RemoteDataStoreError.fetchingError
                }
                return conferences
            }
            .catch { error -> Just<[Conference]> in
                let networkError = RepositoryError.networkError("Refreshing failed. Check internet connection. 💩")
                self.conferencesRepositoryErrorSubject.send(networkError)
                return Just([])
            }
            .sink {
                if !$0.isEmpty {
                    self.localDataStore.updateConferences($0)
                    self.conferencesSubject.send($0)
                }
            }
            .store(in: &disposables)
    }
}


