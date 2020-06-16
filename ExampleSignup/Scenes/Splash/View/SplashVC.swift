//
//  SplashVC.swift
//  ExampleSignup
//
//  Created by Mohammad Zakizadeh on 6/16/20.
//  Copyright © 2020 Communere. All rights reserved.
//

import UIKit

class SplashVC: UIViewController {
    
    @IBOutlet var versionLabel: UILabel!
    
    @Localizable var versionLabelText: String = "Signup"
    
    weak var parentCoordinator: MainCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        versionLabel.text = versionLabelText
        // Do any additional setup after loading the view.
    }

}
