//
//  StoryboardNames.swift
//  ExampleSignup
//
//  Created by Mohammad Zakizadeh on 6/16/20.
//  Copyright © 2020 Communere. All rights reserved.
//

import UIKit

enum Storyboard {
    
    case splash
    
    case login
    case register
    
    
    var storyboard: UIStoryboard {
        
        var storyboardName: String!
        
        switch self {
        case .splash:
            storyboardName = "Splash"
        case .login:
            storyboardName = "Login"
        case .register:
            storyboardName = "Signup"
            
        }
        return UIStoryboard(name: storyboardName, bundle: Bundle.main)
    }
}
 
