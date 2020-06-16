//
//  ProfileCoordinator.swift
//  ExampleSignup
//
//  Created by Mohammad Zakizadeh on 6/16/20.
//  Copyright © 2020 Communere. All rights reserved.
//

import UIKit


class ProfileCoordinator: Coordinator {
    
    weak var parentCoordinator: MainCoordinator?
    
    weak var registerFinishDelegate: RegisterCoordinatorFinishDelegate?
    
    var childCoordinators: [Coordinator]?
    
    var navigationCoordinator: UINavigationController

    init(navigationController: UINavigationController) {
        navigationController.setNavigationBarHidden(true, animated: false)
        self.navigationCoordinator = navigationController
    }

    func start() {
        
    }
    
    deinit {
        print("REMOVED \(self) FROM MEMORY")
    }
}
