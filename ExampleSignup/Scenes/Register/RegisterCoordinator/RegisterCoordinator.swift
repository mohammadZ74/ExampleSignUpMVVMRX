//
//  RegisterCoordinator.swift
//  ExampleSignup
//
//  Created by Mohammad Zakizadeh on 6/16/20.
//  Copyright © 2020 Communere. All rights reserved.
//

import UIKit


class RegisterCoordinator: Coordinator {
    
    weak var parentCoordinator: MainCoordinator?

    
    var childCoordinators: [Coordinator]?
    
    var navigationCoordinator: UINavigationController

    init(navigationController: UINavigationController) {
        navigationController.setNavigationBarHidden(true, animated: false)
        self.navigationCoordinator = navigationController
    }

    func start() {
        let loginVC = LoginVC.instantiate(storyboard: .login)
        navigationCoordinator.pushViewController(loginVC, animated: true)
    }
    
    deinit {
        print("REMOVED \(self) FROM MEMORY")
    }
}
