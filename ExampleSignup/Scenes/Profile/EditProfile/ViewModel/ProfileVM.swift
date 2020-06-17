//
//  ProfileVM.swift
//  ExampleSignup
//
//  Created by Mohammad Zakizadeh on 6/18/20.
//  Copyright © 2020 Communere. All rights reserved.
//

import Foundation
import RxSwift

class ProfileVM {
    
    var userManager: UserManagerProtocol
    private var user: User
    
    var publishUser: PublishSubject<User> = PublishSubject<User>()
    var isLoading: PublishSubject<Bool> = PublishSubject<Bool>()
    let profileErrors: PublishSubject<ValidationResult> = PublishSubject<ValidationResult>()
    let isDeleted: PublishSubject<Bool> = PublishSubject<Bool>()
    
    init(userManager: UserManagerProtocol, user: User) {
        self.userManager = userManager
        self.user = user
    }
    
    
    func requestUserData() {
        publishUser.onNext(user)
    }
    
    func updateProfile(userName: String, mail: String) {
        
        if userName.isEmpty || mail.isEmpty {
            profileErrors.onNext(.failed(message: "Empty Fields"))
            return
        }
        
        if mail.isValidEmail() == false {
            profileErrors.onNext(.failed(message: "Invalid Email"))
            return
        }
        
        self.user.mail = mail
        self.user.username = userName
        
        self.isLoading.onNext(true)
        userManager.editUser(user: user) { [weak self] (result) in
            guard let self = self else {return}
            self.isLoading.onNext(false)
            switch result {
            case .success(let user):
                self.user = user
            case .failure(let validation):
                self.profileErrors.onNext(validation)
            }
        }
        
    }
    
    func deleteUser() {
        
        self.isLoading.onNext(true)
        userManager.deleteUser(user: user) { [weak self] (result) in
            guard let self = self else {return}
            self.isLoading.onNext(false)
            switch result {
            case .success(let deleted):
                self.isDeleted.onNext(deleted)
            case .failure(let validation):
                self.profileErrors.onNext(validation)
            }
        }
    }
    
}
