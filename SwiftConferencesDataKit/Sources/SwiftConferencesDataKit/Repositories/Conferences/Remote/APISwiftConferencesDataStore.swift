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
    
    private let apiClient: APIClient
    private let baseURLString: String

    public init(apiClient: APIClient, baseURLString: String) {
        self.apiClient = apiClient
        self.baseURLString = baseURLString
    }
    
    public func getSwiftConferences() -> AnyPublisher<[SwiftConference], RemoteSwiftConferencesDataStoreError> {
        return getEntity(.SwiftConference)
            .decode(type: [SwiftConference].self, decoder: JSONDecoder())
            .catch {
                Fail(error: .decodingError($0))
            }
            .eraseToAnyPublisher()
    }
    
    private func getEntity(_ entity: Entity) -> AnyPublisher<Data, RemoteSwiftConferencesDataStoreError> {
        guard let url = getUrl(for: .SwiftConference) else {
            return Fail(error: .urlError("URL building error: \(baseURLString + entity.endPoint)")).eraseToAnyPublisher()
        }
        
        return apiClient.getData(atURL: url)
            .catch {
                Fail(error: .fetchingError("Remote fetching failed: \($0.localizedDescription)"))
            }
            .eraseToAnyPublisher()
    }
    
    private func getUrl(for entity: Entity) -> URL? {
        let urlString = baseURLString + entity.endPoint
        return URL(string: urlString)
    }
    
    private enum Entity {
        case SwiftConference
        var endPoint: String {
            switch self {
            case .SwiftConference:
                return "/conferences.yml"
            }
        }
    }
}

