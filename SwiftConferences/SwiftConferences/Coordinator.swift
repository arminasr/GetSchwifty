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

class Coordinator {
    private let window: UIWindow
    @State private var presentWebViewOnHomeView = false
    @State private var webViewUrl: URL!
    
    init(scene: UIWindowScene) {
        self.window = UIWindow(windowScene: scene)
        window.makeKeyAndVisible()
        coordinateToHomeView()
    }
    
    private func coordinateToHomeView() {
        var conferenceRepository: ConferenceRepositoryProtocol {
            ConferenceRepository()
        }
    
        let homeView = ViewsFactory.homeView()
        
        window.rootViewController = UIHostingController(rootView: homeView)
    }
}

protocol HomeViewCoordinating {
    func toggleWebViewPresentation(for url: URL)
}

extension Coordinator: HomeViewCoordinating {
    func toggleWebViewPresentation(for url: URL) {
        webViewUrl = url
        presentWebViewOnHomeView.toggle()
    }
}
