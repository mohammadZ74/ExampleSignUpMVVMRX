//
//  Localizable.swift
//  ExampleSignup
//
//  Created by Mohammad Zakizadeh on 6/16/20.
//  Copyright © 2020 Communere. All rights reserved.
//

import Foundation

@propertyWrapper
struct Localizable {
    private var key: String
    var wrappedValue: String {
        get { NSLocalizedString(key, comment: "") }
        set { key = newValue }
    }
    init(wrappedValue: String) {
        self.key = wrappedValue
    }
}
