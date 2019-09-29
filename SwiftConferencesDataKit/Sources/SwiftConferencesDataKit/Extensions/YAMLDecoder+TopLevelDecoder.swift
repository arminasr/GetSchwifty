//
//  File.swift
//  
//
//  Created by Arminas on 2019-09-29.
//

import Yams
import Combine

extension YAMLDecoder: TopLevelDecoder {
    public typealias Input = String
    public func decode<T>(_ type: T.Type, from: String) throws -> T where T : Decodable {
        try decode(from: from)
    }
}
