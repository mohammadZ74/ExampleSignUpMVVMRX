//
//  LoginVC.swift
//  ExampleSignup
//
//  Created by Mohammad Zakizadeh on 6/17/20.
//  Copyright © 2020 Communere. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LoginVC: UIViewController {
    
    @IBOutlet var usernameTF: UITextField!
    @IBOutlet var passwordTF: UITextField!
    @IBOutlet var signInButton: UIButton!
    
    weak var registerCoordinator: RegisterCoordinator?
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        // Do any additional setup after loading the view.
    }
    func setupBindings() {
        
        let loginViewModel = LoginViewModel(input: (username: usernameTF.rx.text.orEmpty.asDriver(),
                                                    password: passwordTF.rx.text.orEmpty.asDriver(),
                                                    loginTaps: signInButton.rx.tap.asSignal()
            ),
                                            validationService: RegisterValidation.shared,
                                            userManager: UserManager.shared)
        
        loginViewModel.validatedUsername
            .drive(MessageView.sharedInstance.rx.validationResult)
        .disposed(by: disposeBag)
        
        loginViewModel.signingIn
            .bind(to: self.rx.isAnimating)
        .disposed(by: disposeBag)
        
        loginViewModel.loginErrors
            .bind(to: MessageView.sharedInstance.rx.validationResult)
        .disposed(by: disposeBag)
        
        loginViewModel.signedInUser
            .subscribe(onNext: { (user) in
                print(user)
            }).disposed(by: disposeBag)
        
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
