//
//  APIClient.swift
//  
//
//  Created by Arminas on 2019-09-27.
//

import Foundation
import Combine


public enum APIError: Error, LocalizedError {
    case responseError(Int)
    case error(String)
    case genericError
    
    var localizedDescription: String {
        switch self {
        case .error(let error):
            return error
        case .responseError(let status):
            return "Bad response code: \(status)"
        case .genericError:
            return "An unknown error has been occured"
        }
    }
}


@available(iOS 13.0, *)
public protocol APIClient {
    func getData(atURL url: URL) -> Future<Data, APIError>
}
