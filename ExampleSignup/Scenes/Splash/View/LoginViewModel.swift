//
//  LoginViewModel.swift
//  ExampleSignup
//
//  Created by Mohammad Zakizadeh on 6/16/20.
//  Copyright © 2020 Communere. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class LoginViewModel {
    
    let validatedUsername: Driver<ValidationResult>

    let signedInUser: PublishSubject<User> = PublishSubject<User>()
    
    let signingIn: PublishSubject<Bool> = PublishSubject<Bool>()
    
    let loginErrors: PublishSubject<ValidationResult> = PublishSubject<ValidationResult>()
    
    let disposeBag = DisposeBag()

    init(
        input: (
            username: Driver<String>,
            password: Driver<String>,
            loginTaps: Signal<()>
        ),
        validationService: RegisterValidationService,
        userManager: UserManagerProtocol
    ) {

        validatedUsername = input
            .loginTaps
            .withLatestFrom(input.username)
            .flatMap { username in
                return validationService.validateUsername(username)
                    .asDriver(onErrorJustReturn: .failed(message: "Error"))
            }

//        validatedPassword = input.loginTaps
//            .withLatestFrom(input.password)
//            .flatMap { password in
//                return validationService.validatePassword(password)
//                    .asDriver(onErrorJustReturn: .failed(message: "Error"))
//            }

        let usernameAndPassword = Driver.combineLatest(input.username, input.password) { (username: $0, password: $1) }
        
        input.loginTaps
            .throttle(RxTimeInterval.milliseconds(300))
            .withLatestFrom(validatedUsername)
            .filter({ validatedUsername -> Bool in
                return validatedUsername == .valid
            })
            .withLatestFrom(usernameAndPassword)
            .asObservable()
            .subscribe(onNext: { (username, password) in
                self.signingIn.onNext(true)
                userManager.loginUserWith(email: username, password: password) { (result) in
                    self.signingIn.onNext(false)
                    switch result {
                    case .success(let user):
                        self.signedInUser.onNext(user)
                    case .failure(let error):
                        self.loginErrors.onNext(error)
                        break
                    }
                }
            }).disposed(by: disposeBag)
        
    }
    
}
