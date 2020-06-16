//
//  main.swift
//  ExampleSignup
//
//  Created by Mohammad Zakizadeh on 6/16/20.
//  Copyright © 2020 Communere. All rights reserved.
//

import UIKit

class Application: UIApplication, UIApplicationDelegate {
    override var userInterfaceLayoutDirection: UIUserInterfaceLayoutDirection {
        return LanguageManager.shared.currentLanguage.direction == .ltr ? .leftToRight : .rightToLeft
    }
}

/// This function avoids calls for AppDelegate in UnitTest.
private func delegateClassName() -> String? {
    return NSClassFromString("XCTestCase") == nil ? NSStringFromClass(AppDelegate.self) : nil
}

var currentLanguage: SupportedLanguages =  .english /*UserDefaultsConfig.currentLanguage*/

UserDefaultsConfig.appleLanguage = [currentLanguage.identifier]
LanguageManager.shared.currentLanguage = currentLanguage

let argc = CommandLine.argc
let argv = CommandLine.unsafeArgv
  _ = UIApplicationMain(argc, argv, NSStringFromClass(Application.self), delegateClassName())
