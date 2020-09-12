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
    @IBOutlet weak var phoneTextField: SkyFloatingLabelTextField!{
        didSet{
            phoneTextField.applayStyle(Styles.Fields.mainSkyField)
            
            self.phoneTextField.placeholder = "Phone"
            self.phoneTextField.keyboardType = .phonePad
            
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
        viewModel.didPhoneChange(newPhone: self.phoneTextField.text!)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "PROFILE"
        let button = UIBarButtonItem(image: UIImage(named: "trash"), style: .plain, target: self, action: #selector(self.exitButtonAction));
        self.navigationItem.rightBarButtonItems = [button]
    }
    
    override func bind() {
        super.bind()
        
        viewModel.onDataLoaded = {
            [weak self]  data in
            guard let self = self else { return }
            self.nameTextField.text = data?.fullName
            self.emailTextField.text = data?.email
            self.phoneTextField.text = data?.phone
            self.birthDayTextField.text = data?.birthDate.toString()
            self.employmentDayTextField.text = data?.employedDate.toString()
            self.seniorityTextField.text = Date.calculateTimeDifference(from: data?.employedDate)
        }
    }
}
