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
    
    let lightGreyColor = UIColor(red: 197/255, green: 205/255, blue: 205/255, alpha: 1.0)
    let darkGreyColor = UIColor(red: 52/255, green: 42/255, blue: 61/255, alpha: 1.0)
    let overcastBlueColor = UIColor(red: 0, green: 187/255, blue: 204/255, alpha: 1.0)
    
    @IBOutlet weak var frame: UIView!
        {
        didSet{
            frame.layer.cornerRadius = 8
            frame.layer.shadowColor = UIColor.black.cgColor
            frame.layer.shadowOffset = CGSize(width: 0, height: 8.0)
            frame.layer.shadowOpacity = 0.24
            frame.layer.shadowRadius = CGFloat(8.0)
        }
    }
    @IBOutlet weak var password: SkyFloatingLabelTextFieldWithIcon!  {
        didSet{
            password.tintColor = overcastBlueColor
            password.textColor = darkGreyColor
            password.lineColor = lightGreyColor
            password.iconType = .image
            
            password.selectedTitleColor = overcastBlueColor
            password.selectedLineColor = overcastBlueColor
            password.iconImage = UIImage(named: "lock.fill")
        }
    }
    
    @IBOutlet weak var login: SkyFloatingLabelTextFieldWithIcon! {
        didSet{
            login.tintColor = overcastBlueColor // the color of the blinking cursor
            login.textColor = darkGreyColor
            login.lineColor = lightGreyColor
            login.iconType = .image
            login.selectedTitleColor = overcastBlueColor
            login.selectedLineColor = overcastBlueColor
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
