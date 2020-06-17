//
//  UserListViewModel.swift
//  ExampleSignup
//
//  Created by Mohammad Zakizadeh on 6/18/20.
//  Copyright © 2020 Communere. All rights reserved.
//

import Foundation
import RxSwift

class UserListViewModel {
    
    var userManager: UserManagerProtocol
    
    var users: PublishSubject<[User]> = PublishSubject<[User]>()
    var isLoading: PublishSubject<Bool> = PublishSubject<Bool>()
    let userListErrors: PublishSubject<ValidationResult> = PublishSubject<ValidationResult>()
    
    init(userManager: UserManagerProtocol) {
        self.userManager = userManager
    }
    
    func deleteUser(user: User) {
        
        self.isLoading.onNext(true)
        userManager.deleteUser(user: user) { [weak self] (result) in
            guard let self = self else {return}
            self.isLoading.onNext(false)
            switch result {
            case .success(_):
                self.users.onNext(userManager.users.filter {$0.isAdmin == false})
            case .failure(let validation):
                self.userListErrors.onNext(validation)
            }
        }
    }
    
    func fetchUsers() {
        users.onNext(userManager.users.filter {$0.isAdmin == false})
    }
}
