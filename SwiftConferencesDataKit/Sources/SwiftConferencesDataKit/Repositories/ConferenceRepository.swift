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
    
    public func conferencesPublisher() -> Future<[Conference], ConferenceRepositoryError> {
        guard let locallyCachedConferences = localDataStore.getSwiftConferences() else {
            return Future { promise in
                self.remoteDataStore.getSwiftConferences()
                    .receive(on: DispatchQueue.main)
                    .sink(
                        receiveCompletion: {
                            switch $0 {
                            case .failure(let error):
                                promise(.failure(.networkError(error)))
                            case .finished:
                                break
                            }
                        },
                        receiveValue: { [unowned self] in
                            self.localDataStore.updateSwiftConferences($0)
                            promise(.success($0))
                        })
                    .store(in: &self.disposables)
            }
        }

        return Future { promise in
            promise(.success(locallyCachedConferences))
        }
    }
    
    public func favouriteConferencesPublisher() -> Future<[Conference], ConferenceRepositoryError> {
        guard let favouriteConferences = localDataStore.getFavouriteSwiftConferences() else {
            return Future { promise in
                promise(.failure(.favouriteConferencesDecodingError))
            }
        }

        return Future { promise in
            promise(.success(favouriteConferences))
        }
    }
}
