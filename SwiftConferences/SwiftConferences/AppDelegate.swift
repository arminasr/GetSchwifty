//
//  AppDelegate.swift
//  SwiftConferences
//
//  Created by Arminas on 2019-09-25.
//  Copyright © 2019 Arminas. All rights reserved.
//

import UIKit
import SwiftConferencesDataKit
import SwiftConferencesAPIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let apiClient = BaseAPIClient()
        let dataStorage = APISwiftConferencesDataStore(apiClient: apiClient, baseURLString: "https://github.com/Lascorbe/CocoaConferences/blob/master/_data")
        let conferences = dataStorage.getSwiftConferences().sink(receiveCompletion: { error in
            DispatchQueue.main.async {
                print(error.self)
            }
        }, receiveValue: { conferences in
            DispatchQueue.main.async {
                print(conferences)
            }
        })
        
        print(conferences)

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

