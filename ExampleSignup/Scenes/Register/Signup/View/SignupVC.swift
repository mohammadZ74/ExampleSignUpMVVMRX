//
//  SignupVC.swift
//  ExampleSignup
//
//  Created by Mohammad Zakizadeh on 6/17/20.
//  Copyright © 2020 Communere. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SignupVC: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet var nameTF: UITextField!
    @IBOutlet var usernameTF: UITextField!
    @IBOutlet var passwordTF: UITextField!
    @IBOutlet var confirmPasswordTF: UITextField!
    @IBOutlet var signupButton: UIButton!
    @IBOutlet var userImage: UIImageView!
    
    weak var registerCoordinator: RegisterCoordinator?
    
    let registerVM = RegisterVM(registerService: UserManager.shared, validationService: RegisterValidation.shared)
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }
    
    func setupBindings() {
        
        registerVM.isSigningup = { [weak self] isSigningup in
            guard let self = self else {return}
            isSigningup ? self.startAnimating() : self.stopAnimating()
        }
        
        registerVM.registerError = { error in
            switch error {
            case .emptyTF:
                MessageView.sharedInstance.showOnView(message: "Contain Empty textfield", theme: .warning)
            case .validationError(let validationError):
                switch validationError {
                case .failed(let message):
                    MessageView.sharedInstance.showOnView(message: message, theme: .warning)
                default:
                    break
                }
            }
        }
        
        registerVM.signedUp = { [weak self] signedup in
            guard let self = self else {return}
            MessageView.sharedInstance.showOnView(message: "Successfuly signedup. login.", theme: .success)
            self.registerCoordinator?.didFinishSignup()

        }
        
        userImage.addTapGestureRecognizer { [weak self] in
            guard let self = self else {return}
            if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
        
                self.imagePicker.modalPresentationStyle = .overCurrentContext
                self.imagePicker.delegate = self
                self.imagePicker.sourceType = .savedPhotosAlbum
                self.imagePicker.allowsEditing = false
                
                self.present(self.imagePicker, animated: true, completion: nil)
            }
            
        }
        
        
    }
    @IBAction func signupBtnPressed(_ sender: Any) {
        
        registerVM.registerUserWith(fullName: nameTF.text!, email: usernameTF.text!, password: passwordTF.text!, confirmPassword: confirmPasswordTF.text!, image: userImage.image!)
        
    }
    
}

extension SignupVC: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            userImage.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }
}
