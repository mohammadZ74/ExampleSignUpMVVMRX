//
//  Protocols.swift
//  ExampleSignup
//
//  Created by Mohammad Zakizadeh on 6/16/20.
//  Copyright © 2020 Communere. All rights reserved.
//

import RxSwift
import RxCocoa

enum ValidationResult: Error, Equatable {
    case failed(message: String)
    case valid
    case ok(message: String)
}


protocol RegisterValidationService {
    func validateUsername(_ username: String) -> Observable<ValidationResult>
    func validatePassword(_ password: String) -> Observable<ValidationResult>
    func validateRepeatedPassword(_ password: String, repeatedPassword: String) -> ValidationResult
}

