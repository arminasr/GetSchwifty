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
    
    public func getData(atURL url: URL) -> Future<Data, SwiftConferencesAPIError> {
        let session = URLSession.shared
        return Future { promise in
            let task = session.dataTask(with: url) { data, response, error in
                if let err = error {
                    return promise(.failure(.error(err.localizedDescription)))
                }
                guard let resp = response as? HTTPURLResponse,
                    200...299 ~= resp.statusCode else {
                        return promise(.failure(.responseError((response as? HTTPURLResponse)?.statusCode ?? 500)))
                }
                guard let data = data else {
                    return promise(.failure(.genericError))
                }
                return promise(.success(data))
            }
            task.resume()
        }
    }
}
