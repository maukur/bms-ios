//
//  LoginStoryboard.swift
//  OrderKing
//
//  Created by Artem Tischenko on 13.05.2020.
//  Copyright © 2020 Artem Tischenko. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class LoginViewController: BaseViewController {
        
    @IBOutlet weak var frame: UIView!
        {
        didSet{
            frame.applayStyle(Styles.UIViews.shadowUIView)
        }
    }
    @IBOutlet weak var passwordField: SkyFloatingLabelTextFieldWithIcon!  {
        didSet{
            passwordField.applayStyle(Styles.Fields.mainSkyFieldWithImage)
            passwordField.iconImage = UIImage(named: "lock.fill")
        }
    }
    
    @IBOutlet weak var loginField: SkyFloatingLabelTextFieldWithIcon! {
        didSet{
            loginField.applayStyle(Styles.Fields.mainSkyFieldWithImage)
            loginField.iconImage = UIImage(named: "person.fill")
        }
    }
   
    @IBAction func loginTextChanged(_ sender: Any) {
        loginField.errorMessage = ""
    }
    
    @IBAction func passwordTextChanged(_ sender: Any) {
        passwordField.errorMessage = ""
    }
    
    override func bind() {
        viewModel.setErrorStateForEmailField = {
            [weak self] in
            self?.loginField.errorMessage = "Invalid email"
        }
        viewModel.setErrorStateForPasswordField = {
            [weak self] in
            self?.passwordField.errorMessage = "Invalid password"
        }
    }
    
    @IBOutlet weak var loginButton: UIButton!{
        didSet{
            loginButton.layer.cornerRadius = 4
        }
    }
    
    private lazy var viewModel: LoginViewModel = { getViewModel() }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loginAction(_ sender: Any) {
        viewModel.loginAction(login: self.loginField.text, password: self.passwordField.text)
    }
    
}
