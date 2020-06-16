//
//  LoginManager.swift
//  ExampleSignup
//
//  Created by Mohammad Zakizadeh on 6/16/20.
//  Copyright © 2020 Communere. All rights reserved.
//

import Foundation

typealias LoginCompletionHandler = (Result<User, ValidationResult>) -> Void
typealias SignupCompletionHandler = (Result<Bool, ValidationResult>) -> Void
typealias EditUserCompletionHandler = (Result<User, ValidationResult>) -> Void

protocol UserManagerProtocol {
    var userdefault: UserDefaults { get set }
    var users: [User] { get set }
    var logedInUser: User? { get set }
    func loginUserWith(email: String, password: String, completion: @escaping LoginCompletionHandler)
    func signUpUserWith(user: User, completion: @escaping SignupCompletionHandler)
    func editUser(user: User, completion: @escaping EditUserCompletionHandler)
}

class UserManager {
    
    struct UserDefaultkeys {
        static let users: String = "users"
    }
    
    static var shared: UserManagerProtocol = UserManager(userdefaults: UserDefaults.standard)
    
    var userdefault: UserDefaults
    
    var users: [User]
    
    var logedInUser: User?
    
    init(userdefaults: UserDefaults) {
        
        self.userdefault = userdefaults
        
        self.users = userdefault.value([User].self, forKey: UserDefaultkeys.users) ?? []
    }
    
}
extension UserManager: UserManagerProtocol {
    
    func loginUserWith(email: String, password: String, completion: @escaping LoginCompletionHandler) {
        
        // Simulating API Call
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            // No need for capturing self because of the main dispatchQueue will release self after finishes
            
            // check if any users are exist with given credential
            let user = self.users.filter {$0.username == email}.first
            
            guard let foundedUser = user else {
            // no user found so user not exist with given email
                completion(.failure(.failed(message: "No user found with given username")))
                return
            }
            
            // checking the password for user
            if foundedUser.password != password {
                completion(.failure(.failed(message: "Wrong password. Try again.")))
                return
            } else {
                // Credintion Checked. Successfull login.
                completion(.success(foundedUser))
                return
            }
        }
        
    }
    
    func signUpUserWith(user: User, completion: @escaping SignupCompletionHandler) {
        
        // Simulating API Call
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            
            // check for existing user
            if self.users.contains(where: {$0.username == user.username}) {
                completion(.failure(.failed(message: "User already exist!")))
                return
            }
            
            self.users.append(user)
            self.userdefault.set(encodable: self.users, forKey: UserDefaultkeys.users)
            self.userdefault.synchronize()
            
            completion(.success(true))
        }
    }
    
    func editUser(user: User, completion: @escaping EditUserCompletionHandler) {
        
        // Simulating API Call
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            
            // check for existing user
            if self.users.contains(where: {$0.username == user.username}) {
                completion(.failure(.failed(message: "User with given username already exist!")))
                return
            }
            // remove the user from database
            self.users.removeAll(where: {$0.username == $0.username})
            // adding new edited user to database
            self.users.append(user)
            
            // setting new data to database.
            self.userdefault.set(encodable: self.users, forKey: UserDefaultkeys.users)
            self.userdefault.synchronize()
            
            completion(.success(user))
            return
        }
        
    }
}
