//
//  File.swift
//  
//
//  Created by Arminas on 2019-10-21.
//

import Foundation
import Combine

@available(iOS 13.0, *)
public protocol LocalDataStore {
    func conferencesPublisher() -> AnyPublisher<[Conference], Never>
    func updateConferences(_ conferences: [Conference])
}
