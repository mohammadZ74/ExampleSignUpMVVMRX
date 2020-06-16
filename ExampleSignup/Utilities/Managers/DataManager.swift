//
//  DataManager.swift
//  ExampleSignup
//
//  Created by Mohammad Zakizadeh on 6/16/20.
//  Copyright © 2020 Communere. All rights reserved.
//

import Foundation

import RxSwift

class DataManager {
    
    static var shared: DataManager = DataManager()
    
    private init () {
        self.accessToken    = UserDefaultsConfig.accessToken
        self.isUserLoggedIn = UserDefaultsConfig.isUserLoggedIn
        self.mobile         = UserDefaultsConfig.userMobile
    }
    
    var accessToken: String! {
        didSet {
            UserDefaultsConfig.accessToken = accessToken
        }
    }
    
    var isUserLoggedIn: Bool! {
        didSet {
            UserDefaultsConfig.isUserLoggedIn = isUserLoggedIn
        }
    }
    
    var mobile: String! {
        didSet {
            UserDefaultsConfig.userMobile = mobile
        }
    }
}
