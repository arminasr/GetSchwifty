//
//  HomeViewModel.swift
//  GetSchwifty
//
//  Created by Arminas on 2019-10-01.
//  Copyright © 2019 Arminas. All rights reserved.
//

import Foundation
import Combine
import SwiftConferencesDataKit

class HomeViewModel: ObservableObject {
    
    @Published var viewModelDTO = HomeViewModelDTO()
    private let conferenceRepository: RepositoryProtocol
    private var disposables = Set<AnyCancellable>()
    
    init(conferenceRepository: RepositoryProtocol) {
        self.conferenceRepository = conferenceRepository
        subscribeToConferencesPublisher()
        subscribeToErrorPublisher()
    }
    
    func reload() {
        viewModelDTO.isLoading = true
        conferenceRepository.reload()
    }
}

extension HomeViewModel {
    class HomeViewModelDTO: ObservableObject {
        @Published var isLoading = false
        var navigationBarTitle: String = "Schwifty Conferences"
        var infoIconName: String = "info.circle"
        var reloadIconName: String = "goforward"
        var conferencesListViewModel = ConferencesListViewModel()
        
        func reload(with conferences: [Conference]) {
            conferencesListViewModel.reload(with: conferences)
        }
    }
}

extension HomeViewModel {
    private func subscribeToConferencesPublisher() {
        viewModelDTO.isLoading = true
        self.conferenceRepository.conferencesPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] conferences in
                guard let self = self else { return }
                self.viewModelDTO.isLoading = false
                if !conferences.isEmpty {
                    self.viewModelDTO.reload(with: conferences)
                }
            }
            .store(in: &disposables)
    }
    
    private func subscribeToErrorPublisher() {
        viewModelDTO.isLoading = true
        self.conferenceRepository.repositoryErrorPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] error in
                guard let self = self else { return }
                self.viewModelDTO.isLoading = false
                self.handleError(error)
            }
            .store(in: &disposables)
    }
    
    private func handleError(_ error: RepositoryError) {
        switch error {
        case .networkError(let description):
            self.viewModelDTO.conferencesListViewModel.emptyListMessage = description
        }
    }
}
