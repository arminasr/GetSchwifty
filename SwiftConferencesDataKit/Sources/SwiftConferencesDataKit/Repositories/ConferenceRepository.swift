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
    
    public init() {
        reload()
    }
    
    public var conferencesPublisher = PassthroughSubject<[Conference], ConferenceRepositoryError>()
    
    public func reload() {
        localDataStore.swiftConferencesPublisher()
            .receive(on: DispatchQueue.main)
            .sink {
                $0.isEmpty ? self.refresh() : self.conferencesPublisher.send($0)
                self.refresh()
            }
            .store(in: &disposables)
    }
    
    private var disposables = Set<AnyCancellable>()
    private var remoteDataStore: RemoteConferencesDataStore {
        APISwiftConferencesDataStore(apiClient: BaseAPIClient(),
                                     baseURLString: "https://raw.githubusercontent.com/Lascorbe/CocoaConferences/master/_data/")
    }
    private var localDataStore: LocalConferencesDataStore {
        UserDefaultsSwiftConferencesDataStore()
    }
    
    func refresh() {
        remoteDataStore.swiftConferencesPublisher()
            .receive(on: DispatchQueue.main)
            .retry(3)
            .sink(
                receiveCompletion: { [weak self] value in
                    guard let self = self else { return }
                    switch value {
                    case .failure(let error):
                        let networkErrorDescription: ConferenceRepositoryError
                        switch error {
                        case .fetchingError( _):
                            networkErrorDescription = ConferenceRepositoryError.networkError("Fetching conferences failed. Check your internet connection.")
                        case .urlError( _):
                            networkErrorDescription = ConferenceRepositoryError.networkError("Fetching conferences failed. Wrong source.")
                        }
                        self.conferencesPublisher.send(completion: .failure(networkErrorDescription))
                    case .finished:
                        break
                    }
                },
                receiveValue: { [weak self] conferences in
                    guard let self = self else { return }
                    self.localDataStore.updateSwiftConferences(conferences)
                    self.conferencesPublisher.send(conferences)
                }
            )
            .store(in: &disposables)
    }
}
