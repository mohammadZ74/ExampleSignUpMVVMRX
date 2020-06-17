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
    
    var childCoordinators: [Coordinator]?
    
    var navigationCoordinator: UINavigationController
    
    private var user: User

    init(navigationController: UINavigationController, user: User) {
        navigationController.setNavigationBarHidden(false, animated: false)
        self.navigationCoordinator = navigationController
        self.user = user
    }

    func start() {
        if user.isAdmin {
            toUserLists()
        } else {
            toProfile(with: user)
        }
    }
    func toProfile(with profileUser: User) {
        let profileVC = ProfileVC.instantiate(storyboard: .profile)
        profileVC.profileCoordiantor = self 
        let profileVM = ProfileVM(userManager: UserManager.shared, user: profileUser)
        profileVC.profileVM = profileVM
        profileVC.isAdmin = user.isAdmin
        navigationCoordinator.pushViewController(profileVC, animated: true)
    }
    
    func toUserLists() {
        let userListsVC = UserListsVC.instantiate(storyboard: .userLists)
        userListsVC.profileCoordinator = self
        navigationCoordinator.pushViewController(userListsVC, animated: true)
    }
    
    func toSignout() {
        navigationCoordinator.popToRootViewController(animated: true)
        self.parentCoordinator?.childDidFinish(coordinator: self)
    }
    
    deinit {
        print("REMOVED \(self) FROM MEMORY")
    }
}
