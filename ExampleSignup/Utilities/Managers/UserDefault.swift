//
//  UserDefault.swift
//  ExampleSignup
//
//  Created by Mohammad Zakizadeh on 6/16/20.
//  Copyright © 2020 Communere. All rights reserved.
//

import Foundation

enum UserDefaultsKeys: String {
    
    case appleLanguages  = "AppleLanguages"
    case currentLanguage = "currentLanguage"
    case userTheme       = "UserTheme"
    //ofCourse this is temporary and will be moved to keychain
    case accessToken     = "accessToken"
    case isUserLoggedIn  = "isUserLoggedIn"
    case userMobile      = "userMobile"
}

@propertyWrapper
struct UserDefault<T> {
    let key: UserDefaultsKeys
    let defaultValue: T

    init(_ key: UserDefaultsKeys, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }

    var wrappedValue: T {
        get {
            return UserDefaults.standard.object(forKey: key.rawValue) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key.rawValue)
        }
    }
}

struct UserDefaultsConfig {
    
    @UserDefault(.currentLanguage, defaultValue: "en")
    static var currentLanguage: String
    
    @UserDefault(.appleLanguages, defaultValue: ["en"])
    static var appleLanguage: [String]
    
    @UserDefault(.accessToken, defaultValue: "")
    static var accessToken: String
    
    @UserDefault(.userMobile, defaultValue: "")
    static var userMobile: String
    
    @UserDefault(.isUserLoggedIn, defaultValue: false)
    static var isUserLoggedIn: Bool
    
    static func clearUserDefaultfor(_ key: UserDefaultsKeys) {
        UserDefaults.standard.removeObject(forKey: key.rawValue)
        UserDefaults.standard.synchronize()
    }
    static func clearAllUserDefault() {
        if let bundleID = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: bundleID)
        }
        UserDefaults.standard.synchronize()
    }
}
