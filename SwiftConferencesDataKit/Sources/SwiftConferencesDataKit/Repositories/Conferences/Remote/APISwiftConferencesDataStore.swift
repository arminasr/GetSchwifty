//
//  File.swift
//  
//
//  Created by Arminas on 2019-09-28.
//

import Foundation
import SwiftConferencesAPIKit
import Combine

@available(iOS 13.0, *)
public class APISwiftConferencesDataStore: RemoteSwiftConferencesDataStore {
    
    private var subscriptions = Set<AnyCancellable>()
    private let apiClient: APIClient

    public init(apiClient: APIClient) {
        self.apiClient = apiClient
    }

    public func getConferences(from url: URL) -> Future<[SwiftConference], RemoteSwiftConferencesDataStoreError> {
        return Future<[SwiftConference], RemoteSwiftConferencesDataStoreError> { [unowned self] promise in
            self.apiClient.get(url: url)
                .decode(type: [SwiftConference].self, decoder: JSONDecoder())
                .eraseToAnyPublisher()
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        promise(.failure(.decodingError(error)))
                    }
                }, receiveValue: { posts in
                    print(posts.count)
                    promise(.success(posts))
                })
                .store(in: &self.subscriptions)
        }
    }
}
