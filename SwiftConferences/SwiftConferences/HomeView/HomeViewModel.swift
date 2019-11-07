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
    
    private let conferenceRepository: ConferenceRepositoryProtocol
    private var disposables = Set<AnyCancellable>()
    
    init(conferenceRepository: ConferenceRepositoryProtocol) {
        self.conferenceRepository = conferenceRepository
        
        self.conferenceRepository.conferencesPublisher
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] value in
                    guard let self = self else { return }
                    switch value {
                    case .failure(let error):
                        self.viewModelDTO.reload(with: [])
                        self.viewModelDTO.isLoading = false
                        switch error {
                        case .networkError(let description):
                            self.viewModelDTO.conferencesListViewModel.emptyListMessage = description
                        default:
                            self.viewModelDTO.conferencesListViewModel.emptyListMessage = error.localizedDescription
                        }
                    case .finished:
                        self.viewModelDTO.isLoading = false
                        break
                    }
                },
                receiveValue: { [weak self] conferences in
                    guard let self = self else { return }
                    self.viewModelDTO.isLoading = false
                    self.viewModelDTO.reload(with: conferences)
            })
            .store(in: &disposables)
    }
    
    func reload() {
        viewModelDTO.isLoading = true
        conferenceRepository.reload()
    }
}

extension HomeViewModel {
    class HomeViewModelDTO: ObservableObject {
        @Published var isLoading = true
        var navigationBarTitle: String = "Swift Conferences"
        var reloadIconName: String = "goforward"
        var conferencesListViewModel = ConferencesListViewModel()
        
        func reload(with conferences: [Conference]) {
            conferencesListViewModel.reload(with: conferences)
        }
    }
}
