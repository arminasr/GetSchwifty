//
//  APIClient.swift
//  
//
//  Created by Arminas on 2019-09-27.
//

import Foundation
import Combine


public enum SwiftConferencesAPIError: Error, LocalizedError {
    case responseError(Int)
    case urlError(URLError)
    case genericError
    
    var localizedDescription: String {
        switch self {
        case .urlError(let error):
            return error.localizedDescription
        case .responseError(let status):
            return "Bad response code: \(status)"
        case .genericError:
            return "An unknown error has been occured"
        }
    }
}


@available(iOS 13.0, *)
public protocol APIClient {
    func get(url: URL) -> Future<Data, SwiftConferencesAPIError>
}
