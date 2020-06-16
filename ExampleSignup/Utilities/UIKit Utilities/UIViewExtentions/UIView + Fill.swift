//
//  UIView + Fill.swift
//  ExampleSignup
//
//  Created by Mohammad Zakizadeh on 6/17/20.
//  Copyright © 2020 Communere. All rights reserved.
//

import UIKit

extension UIView {
    func fillToSuperView() {
        translatesAutoresizingMaskIntoConstraints = false
        if let superview = superview {
            leftAnchor.constraint(equalTo: superview.leftAnchor).isActive = true
            rightAnchor.constraint(equalTo: superview.rightAnchor).isActive = true
            topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
            bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
        }
    }
}

