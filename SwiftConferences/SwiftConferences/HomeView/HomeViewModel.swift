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
import SwiftUI

class HomeViewModel: ObservableObject {
    
    enum Mode {
        case all
        case favourite
    }
    
    private let conferencesDataStore: SwiftConferencesDataKit.RemoteSwiftConferencesDataStore
    private var disposables = Set<AnyCancellable>()

    init(conferencesDataStore: SwiftConferencesDataKit.RemoteSwiftConferencesDataStore) {
        self.conferencesDataStore = conferencesDataStore
        fetchConferences()
    }
    
    @Published var navigationBarTitle = "Swift Conferences"
    @State private var dataSource: [SwiftConference] = []
    @Published private var mode: Mode = .all
    
    var conferencesListViewModel: ConferencesListViewModel {
        ConferencesListViewModel(conferences: dataSource)
    }
    
    func fetchConferences() {
        conferencesDataStore.getSwiftConferences()
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] value in
                    guard let self = self else { return }
                    switch value {
                    case .failure:
                        self.dataSource = []
                    case .finished:
                        break
                    }
                },
                receiveValue: { [weak self] conferences in
                    guard let self = self else { return }
                    self.dataSource = conferences
            })
            .store(in: &disposables)
    }
}
