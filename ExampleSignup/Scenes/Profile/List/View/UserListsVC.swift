//
//  UserListsVC.swift
//  ExampleSignup
//
//  Created by Mohammad Zakizadeh on 6/18/20.
//  Copyright © 2020 Communere. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class UserListsVC: UIViewController {
    
    @IBOutlet var userListsTableView: UITableView!
    
    var userListViewModel: UserListViewModel = UserListViewModel(userManager: UserManager.shared)
    
    weak var profileCoordinator: ProfileCoordinator?
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        userListViewModel.fetchUsers()
    }
    func setupBindings() {
        
        userListsTableView.register(UINib(nibName: String.init(describing: UserListTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: UserListTableViewCell.self))
        
        userListViewModel.users
            .bind(to: userListsTableView.rx.items(cellIdentifier: String.init(describing: UserListTableViewCell.self), cellType: UserListTableViewCell.self)) {  (row,user,cell) in
            cell.user = user
            cell.deleteBtn.addTapGestureRecognizer { [weak self] in
                guard let self = self else {return}
                self.userListViewModel.deleteUser(user: user)
            }
        }.disposed(by: disposeBag)
        
        userListsTableView.rx.modelSelected(User.self).subscribe(onNext: { [weak self] (user) in
            guard let self = self else {return}
            self.profileCoordinator?.toProfile(with: user)
        }).disposed(by: disposeBag)
        
        
        userListViewModel.isLoading.bind(to: self.rx.isAnimating).disposed(by: disposeBag)
        
        userListViewModel.userListErrors.bind(to: MessageView.sharedInstance.rx.validationResult).disposed(by: disposeBag)
        
        
    }
    
}
