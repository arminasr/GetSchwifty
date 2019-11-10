//
//  Coordinator.swift
//  GetSchwifty
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
    private var homeView: HomeView
    
    init(scene: UIWindowScene) {
        self.window = UIWindow(windowScene: scene)
        window.makeKeyAndVisible()
        homeView = ViewsFactory.homeView() as! HomeView
        coordinateToHomeView()
    }
    
    private mutating func coordinateToHomeView() {
        window.rootViewController = UIHostingController(rootView: homeView)
    }
}
