//
//  SceneDelegate.swift
//  GetSchwifty
//
//  Created by Arminas on 2019-09-25.
//  Copyright © 2019 Arminas. All rights reserved.
//

import UIKit
import SwiftUI
import SwiftConferencesDataKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var coordinator: Coordinator? = nil

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            coordinator = Coordinator(scene: windowScene)
        }
    }
}

