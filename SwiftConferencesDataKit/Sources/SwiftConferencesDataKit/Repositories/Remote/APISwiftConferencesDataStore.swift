//
//  File.swift
//  
//
//  Created by Arminas on 2019-09-28.
//

import Foundation
import SwiftConferencesAPIKit
import Combine
import Yams

@available(iOS 13.0, *)
class APISwiftConferencesDataStore: RemoteConferencesDataStore {
    
    private let apiClient: APIClient
    private let baseURLString: String

    init(apiClient: APIClient, baseURLString: String) {
        self.apiClient = apiClient
        self.baseURLString = baseURLString
    }
    
    func swiftConferencesPublisher() -> AnyPublisher<[Conference], RemoteSwiftConferencesDataStoreError> {
        return getEntity(.SwiftConference)
            .map {
                String(decoding: $0, as: UTF8.self)
            }
            .decode(type: [Conference].self, decoder: YAMLDecoder())
            .catch {
                Fail(error: .fetchingError("Remote fetching failed: \($0.localizedDescription)"))
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

