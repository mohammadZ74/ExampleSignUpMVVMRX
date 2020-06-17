//
//  RegisterViewModel.swift
//  ExampleSignup
//
//  Created by Mohammad Zakizadeh on 6/17/20.
//  Copyright © 2020 Communere. All rights reserved.
//

import UIKit

class RegisterVM {
    
    enum RegisterError {
        case emptyTF
        case validationError(ValidationResult)
    }
    
    var registerService: UserManagerProtocol
    var validationService: RegisterValidationService
    
    var registerError: ((RegisterError) -> Void)?
    var signedUp: ((Bool) -> Void)?
    var isSigningup: ((Bool) -> Void)?
    
    init(registerService: UserManagerProtocol, validationService: RegisterValidationService) {
        self.registerService = registerService
        self.validationService = validationService
    }
    
    func registerUserWith(fullName: String, email: String, password: String, confirmPassword: String, image: UIImage) {
        
        if fullName.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty {
            registerError?(.emptyTF)
            return
        }
        
        if email.isValidEmail() == false {
            registerError?(.validationError(.failed(message: "Invalid Email")))
            return
        }
        
        let passValidation = validationService.validatePassword(password)
        let confirmPassValidation = validationService.validateRepeatedPassword(password, repeatedPassword: confirmPassword)
        
        if passValidation == .valid && confirmPassValidation == .valid {
            let isAdmin = fullName == "admin"
            let user = User(fullName: fullName, mail: email, password: password, image: image, isAdmin: isAdmin)
            isSigningup?(true)
            registerService.signUpUserWith(user: user) { [weak self] (result) in
                guard let self = self else {return}
                self.isSigningup?(false)
                switch result {
                case .success(let isSuccess):
                    self.signedUp?(isSuccess)
                case .failure(let validationError):
                    self.registerError?(.validationError(validationError))
                }
            }
        } else {
            if passValidation != .valid {
                registerError?(.validationError(passValidation))
                return
            }
            if confirmPassValidation != .valid {
                registerError?(.validationError(confirmPassValidation))
                return
            }
            
        }
        
    }
}
