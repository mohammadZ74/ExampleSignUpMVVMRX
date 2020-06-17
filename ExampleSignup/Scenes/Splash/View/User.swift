//
//  User.swift
//  ExampleSignup
//
//  Created by Mohammad Zakizadeh on 6/16/20.
//  Copyright © 2020 Communere. All rights reserved.
//

import UIKit

struct User: Codable {
    
    var fullName: String
    var mail: String
    var password: String
    var isAdmin: Bool
    private var userImageData: Data?
    
    init(fullName: String, mail: String, password: String, image: UIImage, isAdmin: Bool) {
        
        self.fullName = fullName
        self.mail     = mail
        self.password = password
        self.isAdmin  = isAdmin
        // Data
        self.userImageData = image.pngData()
    }
    
    init() {
        self.fullName = ""
        self.mail     = ""
        self.password = ""
        self.isAdmin  = false
    }
    
    var userImage: UIImage? {
        get {
            guard let image = userImageData else { return nil }
            return UIImage(data: image)
        }
        set {
            self.userImageData = newValue?.pngData()
        }
    }
}
