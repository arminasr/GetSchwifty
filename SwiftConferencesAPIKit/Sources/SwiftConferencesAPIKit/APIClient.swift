//
//  APIClient.swift
//  
//
//  Created by Arminas on 2019-09-27.
//

import Foundation
import Combine

@available(iOS 13.0, *)
public protocol APIClient {
    func get(url: URL) -> URLSession.DataTaskPublisher
}
