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
        self.navigationCoordinator = navigationController
    }

    func start() {
        let loginVC = LoginVC.instantiate(storyboard: .login)
        navigationCoordinator.setNavigationBarHidden(true, animated: true)
        loginVC.registerCoordinator = self
        navigationCoordinator.pushViewController(loginVC, animated: true)
    }
    
    func toSignUp() {
        let signup = SignupVC.instantiate(storyboard: .register)
        navigationCoordinator.setNavigationBarHidden(false, animated: true)
        signup.registerCoordinator = self
        navigationCoordinator.pushViewController(signup, animated: true)
    }
    
    func loginWith(user: User) {
        parentCoordinator?.toProfileScreenWith(user: user)
    }
    
    func didFinishSignup() {
        navigationCoordinator.popViewController(animated: true)
    }
    
    
    deinit {
        print("REMOVED \(self) FROM MEMORY")
    }
}
