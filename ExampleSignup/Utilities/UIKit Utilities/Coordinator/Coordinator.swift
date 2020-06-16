//
//  Coordinator.swift
//  ExampleSignup
//
//  Created by Mohammad Zakizadeh on 6/16/20.
//  Copyright © 2020 Communere. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


protocol Coordinator: class {
    var childCoordinators: [Coordinator]? { get set }
    var navigationCoordinator: UINavigationController { get set }
    func start()
}

extension Coordinator {
    func popViewController() {
        navigationCoordinator.popViewController(animated: true)
    }
    
    func popToRootViewController() {
        navigationCoordinator.popToRootViewController(animated: true)
    }
    
    func childDidFinish(coordinator: Coordinator) {
        childCoordinators = childCoordinators?.filter {$0 !== coordinator}
    }
}
 
