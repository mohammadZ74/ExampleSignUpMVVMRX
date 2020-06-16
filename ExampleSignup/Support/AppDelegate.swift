//
//  AppDelegate.swift
//  ExampleSignup
//
//  Created by Mohammad Zakizadeh on 6/16/20.
//  Copyright © 2020 Communere. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    var appCoordinator: MainCoordinator!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        setupCoordinator()
        
        return true
    }
    
    fileprivate func setupCoordinator() {
        window = UIWindow(frame: UIScreen.main.bounds)
        let navController = UINavigationController()
        
        appCoordinator = MainCoordinator(navigationController: navController, window: window)
        appCoordinator.start()
    }
    
    func setupIQKeyboardManager() {
        IQKeyboardManager.shared.enable = true
    }
}

