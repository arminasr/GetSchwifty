//
//  HomeViewModel.swift
//  SwiftConferences
//
//  Created by Arminas on 2019-10-01.
//  Copyright © 2019 Arminas. All rights reserved.
//

import Foundation
import Combine
import SwiftConferencesDataKit

class HomeViewModel: ObservableObject {
    @Published var dataSource: ConferenceCardViewModel?
    
    private let conferencesDataStore: SwiftConferencesDataKit.RemoteSwiftConferencesDataStore
    private var disposables = Set<AnyCancellable>()

    init(conferencesDataStore: SwiftConferencesDataKit.RemoteSwiftConferencesDataStore) {
      self.conferencesDataStore = conferencesDataStore
    }
    
    func refresh() {
        
    }
}
