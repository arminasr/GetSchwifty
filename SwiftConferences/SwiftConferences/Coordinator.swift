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
    private let scene: UIWindowScene
    private let window: UIWindow
    
    init(scene: UIWindowScene) {
        self.scene = scene
        self.window = UIWindow(windowScene: scene)
        window.makeKeyAndVisible()
    }
    
    func coordinate() {
        var conferenceRepository: ConferenceRepositoryProtocol {
            ConferenceRepository()
        }
        let homeView = HomeViewFactory.makeHomeView(conferenceRepository: conferenceRepository)
        window.rootViewController = UIHostingController(rootView: homeView)
    }
}
