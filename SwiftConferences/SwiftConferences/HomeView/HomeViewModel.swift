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

class HomeViewModel {
    
    var viewModelDTO = HomeViewModelDTO()
    
    private let conferenceRepository: ConferenceRepositoryProtocol
    private var disposables = Set<AnyCancellable>()

    init(conferenceRepository: ConferenceRepositoryProtocol) {
        self.conferenceRepository = conferenceRepository
        loadConferences()
    }
    
    private func loadConferences() {
        conferenceRepository.getConferences()
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] value in
                    guard let self = self else { return }
                    switch value {
                    case .failure:
                        self.viewModelDTO.reload(with: [])
                    case .finished:
                        break
                    }
                },
                receiveValue: { [weak self] conferences in
                    guard let self = self else { return }
                    self.viewModelDTO.reload(with: conferences)
            })
            .store(in: &disposables)
    }
}

extension HomeViewModel {
    class HomeViewModelDTO {
        var navigationBarTitle: String = "Swift Conferences"
        var conferencesListViewModel = ConferencesListViewModel()
        
        func reload(with conferences: [Conference]) {
            conferencesListViewModel.reload(with: conferences)
        }
    }
}
