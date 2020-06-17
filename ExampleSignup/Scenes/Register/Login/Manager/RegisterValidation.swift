//
//  RegisterValidation.swift
//  ExampleSignup
//
//  Created by Mohammad Zakizadeh on 6/17/20.
//  Copyright © 2020 Communere. All rights reserved.
//

import Foundation
import RxSwift


class RegisterValidation: RegisterValidationService {
    
    static var shared: RegisterValidationService = RegisterValidation()
    
    func validateUsername(_ username: String) -> Observable<ValidationResult> {
        if username.isEmpty {
            return .just(.failed(message: "Empty text"))
        }
        if username.isValidEmail() == false {
            return .just(.failed(message: "Please enter valid email"))
        }
        return .just(.valid)
    }
    
    func validatePassword(_ password: String) -> ValidationResult {
        if password.isEmpty {
            return .failed(message: "Empty text")
        }
        if password.numberAndCapitalComplexity() == false {
            return .failed(message: "Password Complexity Error")
        }
        return .valid
    }
    
    
    func validateRepeatedPassword(_ password: String, repeatedPassword: String) -> ValidationResult {
        if repeatedPassword.count == 0 {
            return .failed(message: "Empty text")
        }
        if repeatedPassword != password {
            return .failed(message: "Password and confirm password is not same")
        }
        else {
            return .valid
        }
    }
    
    
    
}
extension String {
    func isValidEmail() -> Bool {
        // here, `try!` will always succeed because the pattern is valid
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
    func numberAndCapitalComplexity() -> Bool {
        let capitalLetterRegEx  = ".*[A-Z]+.*"
        let texttest = NSPredicate(format:"SELF MATCHES %@", capitalLetterRegEx)
        guard texttest.evaluate(with: self) else { return false }

        let numberRegEx  = ".*[0-9]+.*"
        let texttest1 = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
        guard texttest1.evaluate(with: self) else { return false }

        return true
    }
}
