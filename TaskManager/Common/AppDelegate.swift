//
//  AppDelegate.swift
//  TaskManager
//
//  Created by Aleksandar Atanackovic on 12/13/17.
//  Copyright © 2017 Aleksandar Atanackovic. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coordinator: AppCoordinator!

    // MARK: App Lifecycle
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow()
        self.window?.makeKeyAndVisible()
        DBManager.configure()
        ThemeManager.configure()
        UrlManager.configure()

        self.coordinator = AppCoordinator(window: self.window!)
        self.coordinator.start()
        
        return true
    }

}

