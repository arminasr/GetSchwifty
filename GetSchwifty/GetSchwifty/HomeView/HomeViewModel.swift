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
    
    @Published var isLoading = false
    @Published var conferencesListViewModel = ConferencesListViewModel()
    
    var navigationBarTitle: String = "Schwifty Conferences"
    var infoIconName: String = "info.circle"
    var reloadIconName: String = "goforward"
    
    private let conferenceRepository: RepositoryProtocol
    private var disposables = Set<AnyCancellable>()
    
    init(conferenceRepository: RepositoryProtocol) {
        self.conferenceRepository = conferenceRepository
        subscribeToConferencesPublisher()
        subscribeToErrorPublisher()
    }
    
    func reload() {
        isLoading = true
        conferenceRepository.reload()
    }
}

extension HomeViewModel {
    private func subscribeToConferencesPublisher() {
        isLoading = true
        self.conferenceRepository.conferencesPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] conferences in
                guard let self = self else { return }
                self.isLoading = false
                if !conferences.isEmpty {
                    self.conferencesListViewModel.reload(with: conferences)
                }
            }
            .store(in: &disposables)
    }
    
    private func subscribeToErrorPublisher() {
        isLoading = true
        self.conferenceRepository.repositoryErrorPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] error in
                guard let self = self else { return }
                self.isLoading = false
                self.handleError(error)
            }
            .store(in: &disposables)
    }
    
    private func handleError(_ error: RepositoryError) {
        switch error {
        case .networkError(let description):
            self.conferencesListViewModel.emptyListMessage = description
        }
    }
}
