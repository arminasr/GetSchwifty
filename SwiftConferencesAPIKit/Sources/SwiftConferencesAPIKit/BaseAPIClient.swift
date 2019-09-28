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
    public init() {

    }
    
    public func get(url: URL) -> URLSession.DataTaskPublisher {
        URLSession.shared.dataTaskPublisher(for: url)
    }
}
