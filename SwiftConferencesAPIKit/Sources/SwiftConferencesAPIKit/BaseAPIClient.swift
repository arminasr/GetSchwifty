//
//  BaseAPIClient.swift
//  
//
//  Created by Arminas on 2019-09-27.
//

import Foundation
import Combine

@available(iOS 13.0, *)
public class BaseAPIClient: APIClient {
    
    public init(){}
    private var subscriptions = Set<AnyCancellable>()
    
    public func get(url: URL) -> Future<Data, SwiftConferencesAPIError> {
        return Future<Data, SwiftConferencesAPIError> { [unowned self] promise in
            URLSession.shared.dataTaskPublisher(for: url)
                .tryMap { (data, response) -> Data in
                    guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
                        throw SwiftConferencesAPIError.responseError((response as? HTTPURLResponse)?.statusCode ?? 500)
                    }
                    return data
            }
            .receive(on: RunLoop.main)
            .sink(
                receiveCompletion: {
                    if case let .failure(error) = $0 {
                        switch error {
                        case let urlError as URLError:
                            promise(.failure(.urlError(urlError)))
                        case let apiError as SwiftConferencesAPIError:
                            promise(.failure(apiError))
                        default:
                            promise(.failure(.genericError))
                        }
                    }
                },
                receiveValue: {
                    promise(.success($0))
                }
            )
            .store(in: &self.subscriptions)
        }
    }
    
    private func handleReceiveCompletion(_ completion: Subscribers.Completion<Error>, for promise: (Result<Data, SwiftConferencesAPIError>) -> Void) {

    }
}
