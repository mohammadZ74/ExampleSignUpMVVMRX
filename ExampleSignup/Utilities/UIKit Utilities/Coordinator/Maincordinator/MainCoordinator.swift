//
//  MainCoordinator.swift
//  ExampleSignup
//
//  Created by Mohammad Zakizadeh on 6/16/20.
//  Copyright © 2020 Communere. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MainCoordinator: NSObject, Coordinator {
    
    // MARK: - Properties
    let window: UIWindow?
    
    var childCoordinators: [Coordinator]? = [Coordinator]()
    var navigationCoordinator: UINavigationController
    
    let disposeBag = DisposeBag()
    
    init(navigationController: UINavigationController, window: UIWindow?) {
        self.navigationCoordinator = navigationController
        self.window = window
    }
    
    func start() {
        
        guard let window = window else { return }
        
        window.rootViewController = navigationCoordinator
        window.makeKeyAndVisible()
        
        toSplashScreen()
    }
    
    func toSplashScreen() {
        let splashVC = SplashVC.instantiate(storyboard: .splash)
        navigationCoordinator.setViewControllers([splashVC], animated: false)
        splashVC.parentCoordinator = self
    }
    
    func toHomeScene() {
        
        navigationCoordinator.setViewControllers([], animated: false)
        
    }
    
}
