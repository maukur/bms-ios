//
//  ProfileViewController.swift
//  bms
//
//  Created by Sergey on 13.08.2020.
//  Copyright © 2020 Artem Tischenko. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class ProfileViewController: BaseViewController {
    
    @IBOutlet weak var nameTextField: SkyFloatingLabelTextField!{
        didSet{
            nameTextField.applayStyle(Styles.Fields.mainSkyField)
            self.nameTextField.placeholder = "FIO"
            self.nameTextField.isEnabled = false
            
        }
    }
    @IBOutlet weak var emailTextField: SkyFloatingLabelTextField!{
        didSet{
            emailTextField.applayStyle(Styles.Fields.mainSkyField)
            self.emailTextField.placeholder = "Email"
            self.emailTextField.isEnabled = false
        }
    }
    @IBOutlet weak var phoneNumberField: SkyFloatingLabelTextField!{
        didSet{
            phoneNumberField.applayStyle(Styles.Fields.mainSkyField)
            
            self.phoneNumberField.placeholder = "Phone"
            self.phoneNumberField.keyboardType = .phonePad
            
        }
    }
    @IBOutlet weak var birthDayTextField: SkyFloatingLabelTextField!{
        didSet{
            birthDayTextField.applayStyle(Styles.Fields.mainSkyField)
            self.birthDayTextField.placeholder = "Birth day"
            self.birthDayTextField.isEnabled = false
        }
    }
    @IBOutlet weak var employmentDayTextField: SkyFloatingLabelTextField!{
        didSet{
            employmentDayTextField.applayStyle(Styles.Fields.mainSkyField)
            self.employmentDayTextField.placeholder = "Date of employment"
            self.employmentDayTextField.isEnabled = false
        }
    }
    @IBOutlet weak var seniorityTextField: SkyFloatingLabelTextField!{
        didSet{
            seniorityTextField.applayStyle(Styles.Fields.mainSkyField)
            self.seniorityTextField.placeholder = "Seniority"
            self.seniorityTextField.isEnabled = false
        }
    }
    @IBOutlet weak var saveButton: UIButton!{
        didSet{
            saveButton.applayStyle(Styles.Buttons.mainButton)
        }
    }
    
    private lazy var viewModel: ProfileViewModel = { getViewModel() }()
    
    @IBAction func saveButtonAction(_ sender: Any) {
        viewModel.updateUserInfo()
    }
    @objc func exitButtonAction(_ sender: Any) {
        viewModel.exit()
    }
    
    @IBAction func phoneFieldTextChanged(_ sender: Any) {
        viewModel.didPhoneChange(newPhone: self.phoneNumberField.text!)
        phoneNumberField.errorMessage = ""
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "PROFILE"
        setupLogoutButton()
        doneTextFieldButton(textField: phoneNumberField)
    }
    
    func setupLogoutButton() {
        let logoutButton = UIButton(type: .custom)
        logoutButton.frame(forAlignmentRect: CGRect(x: 0, y: 0, width: 20, height: 20))
        logoutButton.setImage(UIImage(named: "logout")?.withRenderingMode(.alwaysTemplate), for: .normal)
        logoutButton.tintColor = .white
        logoutButton.addTarget(self, action: #selector(self.exitButtonAction), for: .touchUpInside)
        let logoutBarButtonItem = UIBarButtonItem(customView: logoutButton)
        let currentWidth = logoutBarButtonItem.customView?.widthAnchor.constraint(equalToConstant: 20)
        currentWidth?.isActive = true
        let currentHeight = logoutBarButtonItem.customView?.heightAnchor.constraint(equalToConstant: 20)
        currentHeight?.isActive = true
        self.navigationItem.rightBarButtonItems = [logoutBarButtonItem]
    }
    
    override func bind() {
        super.bind()
        
        viewModel.onDataLoaded = {
            [weak self]  data in
            guard let self = self else { return }
            self.nameTextField.text = data?.fullName
            self.emailTextField.text = data?.email
            self.phoneNumberField.text = data?.phone
            self.birthDayTextField.text = data?.birthDate.toString()
            self.employmentDayTextField.text = data?.employedDate.toString()
            self.seniorityTextField.text = Date.calculateTimeDifference(from: data?.employedDate)
        }
        viewModel.setErrorStateForPhoneNumberField = {
            [weak self] in
            self?.phoneNumberField.errorMessage = "Invalid phone number"
        }
    }
}
