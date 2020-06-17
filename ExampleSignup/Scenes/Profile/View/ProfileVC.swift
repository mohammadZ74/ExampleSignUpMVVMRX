//
//  ProfileVC.swift
//  ExampleSignup
//
//  Created by Mohammad Zakizadeh on 6/17/20.
//  Copyright © 2020 Communere. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ProfileVC: UIViewController {
    
    
    @IBOutlet var usernameTF: UITextField!
    @IBOutlet var emailTF: UITextField!
    @IBOutlet var userImage: UIImageView!
    @IBOutlet var userFullName: UILabel!
    @IBOutlet var bottomStackView: UIStackView!
    @IBOutlet var updateBtn: UIButton!
    @IBOutlet var deleteBtn: UIButton!
    
    var disposeBag: DisposeBag = DisposeBag()
    
    var profileVM: ProfileVM!
    
    var profileCoordiantor: ProfileCoordinator?
    
    var isAdmin: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupBindings()
        profileVM.requestUserData()
    }
    func setupBindings() {
        
        updateBtn.rx
            .tap
            .subscribe(onNext: { [weak self] (_) in
                guard let self = self else {return}
                self.profileVM.updateProfile(userName: self.usernameTF.text!, mail: self.emailTF.text!)
            }).disposed(by: disposeBag)
        
        deleteBtn.rx
        .tap
        .subscribe(onNext: { [weak self] (_) in
            guard let self = self else {return}
            self.profileVM.deleteUser()
        }).disposed(by: disposeBag)
        
        profileVM.publishUser
            .subscribe(onNext: { [weak self] (user) in
                guard let self = self else {return}
                self.userFullName.text = user.fullName
                self.userImage.image = user.userImage
                self.emailTF.text = user.mail
                self.usernameTF.text = user.username
            }).disposed(by: disposeBag)
        
        profileVM.isLoading.bind(to: self.rx.isAnimating).disposed(by: disposeBag)
        
        profileVM.isDeleted.subscribe(onNext: { (isDeleted) in
            if isDeleted {
                self.profileCoordiantor?.toSignout()
            }
            }).disposed(by: disposeBag)
        
        profileVM.profileErrors.bind(to: MessageView.sharedInstance.rx.validationResult).disposed(by: disposeBag)
        
        
    }
    
    
    func setupView() {
        
        
        if isAdmin {
            bottomStackView.isHidden = true
            usernameTF.alpha = 0.8
            emailTF.alpha = 0.8
            usernameTF.isUserInteractionEnabled = false
            emailTF.isUserInteractionEnabled = false
        }
    }
}
