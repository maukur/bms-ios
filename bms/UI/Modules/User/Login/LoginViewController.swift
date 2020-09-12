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
    @IBOutlet weak var password: SkyFloatingLabelTextFieldWithIcon!  {
        didSet{
            password.applayStyle(Styles.Fields.mainSkyFieldWithImage)
            password.iconImage = UIImage(named: "lock.fill")
        }
    }
    
    @IBOutlet weak var login: SkyFloatingLabelTextFieldWithIcon! {
        didSet{
            login.applayStyle(Styles.Fields.mainSkyFieldWithImage)
            login.iconImage = UIImage(named: "person.fill")
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
        viewModel.loginAction(login: self.login.text, password: self.password.text)
    }
    
}
