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
    private var conferences: [Conference] = [] {
        didSet {
            viewModelDTO.conferences = conferences
        }
    }

    init(conferenceRepository: ConferenceRepositoryProtocol) {
        self.conferenceRepository = conferenceRepository
        loadConferences()
    }
    
    func loadConferences() {
        conferenceRepository.getConferences()
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] value in
                    guard let self = self else { return }
                    switch value {
                    case .failure:
                        self.conferences = []
                    case .finished:
                        break
                    }
                },
                receiveValue: { [weak self] conferences in
                    guard let self = self else { return }
                    self.conferences = conferences
            })
            .store(in: &disposables)
    }
}

extension HomeViewModel {
    class HomeViewModelDTO: ObservableObject {
        @Published var conferences: [Conference] = [] {
            didSet {
                conferencesListViewModel.conferences = conferences
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
