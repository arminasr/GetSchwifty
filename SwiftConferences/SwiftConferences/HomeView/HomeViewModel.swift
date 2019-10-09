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
    
    @Published var viewModelDTO = HomeViewModelDTO()

    private let conferencesDataStore: SwiftConferencesDataKit.RemoteSwiftConferencesDataStore
    private var disposables = Set<AnyCancellable>()
    @Published private var dataSource: [SwiftConference] = []
    

    init(conferencesDataStore: SwiftConferencesDataKit.RemoteSwiftConferencesDataStore) {
        self.conferencesDataStore = conferencesDataStore
        fetchConferences()
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

extension HomeViewModel {
    class HomeViewModelDTO: ObservableObject {
        @Published var navigationBarTitle: String = "Swift Conferences"
        //@Published var navigationBarViewModel: NavigationBarViewModel
        @Published var conferencesListViewModel = ConferencesListViewModel(conferences: [])
    }
    
    enum Mode {
        case favourite
        case all
    }
}
