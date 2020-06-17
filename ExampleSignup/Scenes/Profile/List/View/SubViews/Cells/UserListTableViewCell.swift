//
//  UserListTableViewCell.swift
//  ExampleSignup
//
//  Created by Mohammad Zakizadeh on 6/18/20.
//  Copyright © 2020 Communere. All rights reserved.
//

import UIKit

class UserListTableViewCell: UITableViewCell {
        
    @IBOutlet var userImage: UIImageView!
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var deleteBtn: UIImageView!
    
    var user: User! {
        didSet {
            self.userImage.image = user.userImage
            self.userNameLabel.text = user.fullName
        }
    }
}
