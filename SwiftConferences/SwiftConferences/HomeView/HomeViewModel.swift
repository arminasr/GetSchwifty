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
    
    enum HomeViewMode {
        case all
        case favourite
    }
    
    @Published var viewModelDTO = HomeViewModelDTO()
    
    var mode: HomeViewMode = .all {
        didSet {
            if mode == .favourite {
                viewModelDTO.favouriteIconName = "star.fill"
            } else {
                viewModelDTO.favouriteIconName = "star"
            }
            loadConferences(mode)
        }
    }
    
    private let conferenceRepository: ConferenceRepositoryProtocol
    private var disposables = Set<AnyCancellable>()

    init(conferenceRepository: ConferenceRepositoryProtocol) {
        self.conferenceRepository = conferenceRepository
        loadConferences(mode)
    }
        
    private func loadConferences(_ mode: HomeViewMode) {
        viewModelDTO.isLoading = true
        mode == .all ? loadAllConferences() : loadFavouriteConferences()
    }
    
    private func loadAllConferences() {
        conferenceRepository.conferencesPublisher()
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] value in
                    guard let self = self else { return }
                    switch value {
                    case .failure(let error):
                        self.viewModelDTO.reload(with: [])
                        self.viewModelDTO.isLoading = false
                        self.viewModelDTO.conferencesListViewModel.emptyListMessage = error.localizedDescription
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
    
    private func loadFavouriteConferences() {
        conferenceRepository.favouriteConferencesPublisher()
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] value in
                    guard let self = self else { return }
                    switch value {
                    case .failure:
                        self.viewModelDTO.reload(with: [])
                        self.viewModelDTO.isLoading = false
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
}

extension HomeViewModel {
    class HomeViewModelDTO: ObservableObject {
        @Published var favouriteIconName: String = "star"
        @Published var isLoading = false
        var navigationBarTitle: String = "Swift Conferences"
        var conferencesListViewModel = ConferencesListViewModel()
        
        func reload(with conferences: [Conference]) {
            conferencesListViewModel.reload(with: conferences)
        }
    }
}
