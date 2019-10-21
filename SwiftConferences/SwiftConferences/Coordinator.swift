//
//  Coordinator.swift
//  SwiftConferences
//
//  Created by Arminas Ruzgas on 18/10/2019.
//  Copyright © 2019 Arminas. All rights reserved.
//

import Foundation
import SwiftConferencesDataKit
import SwiftConferencesAPIKit
import UIKit
import SwiftUI

struct Coordinator {
    private let window: UIWindow
    @State private var presentWebViewOnHomeView = true
    var homeView: HomeView
    
    init(scene: UIWindowScene) {
        self.window = UIWindow(windowScene: scene)
        window.makeKeyAndVisible()
        homeView = ViewsFactory.homeView() as! HomeView
        coordinateToHomeView()
    }
    
    private mutating func coordinateToHomeView() {
        var conferenceRepository: ConferenceRepositoryProtocol {
            ConferenceRepository()
        }
        homeView.viewModel.coordinator = self
        window.rootViewController = UIHostingController(rootView: homeView)
    }
}

protocol HomeViewCoordinating {
    func toggleWebViewPresentation(for url: URL)
}

extension Coordinator: HomeViewCoordinating {
    func toggleWebViewPresentation(for url: URL) {
    }
}
