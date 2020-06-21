//
//  ReactiveExtensiones.swift
//  ExampleSignup
//
//  Created by Mohammad Zakizadeh on 6/21/20.
//  Copyright © 2020 Communere. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension UIViewController: loadingViewable {}

extension Reactive where Base: UIViewController {
    
    /// Bindable sink for `startAnimating()`, `stopAnimating()` methods.
    public var isAnimating: Binder<Bool> {
        return Binder(self.base, binding: { (vc, active) in
            if active {
                vc.startAnimating()
            } else {
                vc.stopAnimating()
            }
        })
    }
    
}


extension Reactive where Base: MessageView {
    
    var validationResult: Binder<ValidationResult> {
        return Binder(self.base, binding: { (view, message) in
            switch message {
            case .ok(let message):
                view.showOnView(message: message, theme: .success)
            case .failed(let error):
                view.showOnView(message: error, theme: .error)
            default:
                break
            }
        })
    }
    
}
