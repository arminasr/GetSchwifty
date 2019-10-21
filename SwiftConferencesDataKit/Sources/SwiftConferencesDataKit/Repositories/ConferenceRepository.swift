//
//  ConferenceRepository.swift
//  
//
//  Created by Arminas on 2019-10-10.
//

import Foundation
import Combine
import SwiftConferencesAPIKit

fileprivate let stored = UserDefaults.standard
fileprivate let recordsKey = "UserDefaultsConferenceRecords"

@available(iOS 13.0, *)
public class ConferenceRepository: ConferenceRepositoryProtocol {
    
    public init(){}
    
    private var remoteDataStore: RemoteConferencesDataStore {
        APISwiftConferencesDataStore(apiClient: BaseAPIClient(),
                                     baseURLString: "https://raw.githubusercontent.com/Lascorbe/CocoaConferences/master/_data/")
    }
    
    public func getConferences() -> AnyPublisher<[Conference], RemoteSwiftConferencesDataStoreError> {
        remoteDataStore.getSwiftConferences()
    }
    
    func updateConferenceRecords(conferences: [Conference]) {
        if let encodedRecords = try? PropertyListEncoder().encode(conferences){
            stored.set(encodedRecords, forKey: recordsKey)}
    }
    
    func initializeConferenceRecords() -> [Conference] {
        guard let records = stored.value(forKey: recordsKey) as? Data,
            let decodedRecords
                = try? PropertyListDecoder()
                    .decode([Conference].self,
                            from: records) else {return [Conference]()}
        return decodedRecords
    }
}
