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
    @Published private var swiftConferences: [SwiftConference] = [] {
        didSet {
            viewModelDTO.swiftConferences = swiftConferences
        }
    }
    
    private let conferencesDataStore: SwiftConferencesDataKit.RemoteSwiftConferencesDataStore
    private var disposables = Set<AnyCancellable>()

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
                        self.swiftConferences = []
                    case .finished:
                        break
                    }
                },
                receiveValue: { [weak self] conferences in
                    guard let self = self else { return }
                    self.swiftConferences = conferences
            })
            .store(in: &disposables)
    }
}

extension HomeViewModel {
    class HomeViewModelDTO: ObservableObject {
        @Published var swiftConferences: [SwiftConference] = [] {
            didSet {
                conferencesListViewModel.conferences = swiftConferences
            }
        }
        @Published var navigationBarTitle: String = "Swift Conferences"
        //@Published var navigationBarViewModel: NavigationBarViewModel
        @Published var conferencesListViewModel = ConferencesListViewModel()
    }
    
    enum Mode {
        case favourite
        case all
    }
}
