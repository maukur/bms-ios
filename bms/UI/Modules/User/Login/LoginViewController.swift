//
//  LoginStoryboard.swift
//  OrderKing
//
//  Created by Artem Tischenko on 13.05.2020.
//  Copyright © 2020 Artem Tischenko. All rights reserved.
//

import UIKit


class LoginViewController: BaseViewController {
    
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var login: UITextField!
    
    private lazy var viewModel: LoginViewModel = { getViewModel() }()
    
    @IBAction func loginAction(_ sender: Any) {
        viewModel.loginAction(login: self.login.text, password: self.password.text)
    }
    
}
