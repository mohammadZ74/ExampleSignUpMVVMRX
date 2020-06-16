//
//  DataManager.swift
//  ExampleSignup
//
//  Created by Mohammad Zakizadeh on 6/16/20.
//  Copyright © 2020 Communere. All rights reserved.
//

import Foundation


class DataManager {
    
    static var shared: DataManager = DataManager()
    
    private init () {}
    
    var user: User?
}
