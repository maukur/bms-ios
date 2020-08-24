//
//  ProfileViewController.swift
//  bms
//
//  Created by Sergey on 13.08.2020.
//  Copyright © 2020 Artem Tischenko. All rights reserved.
//

import UIKit
import SwiftUI

class ProfileViewController: BaseViewController {
    
    @IBOutlet weak var nameField: EditableProfileView!
    @IBOutlet weak var emailField: EditableProfileView!
    @IBOutlet weak var phoneField: EditableProfileView!
    @IBOutlet weak var birthDateField: EditableProfileView!
    @IBOutlet weak var employedDateField: EditableProfileView!
    @IBOutlet weak var seniorityField: EditableProfileView!
    @IBOutlet weak var scrollVIew: UIScrollView!
    
    
    private lazy var viewModel: ProfileViewModel = { getViewModel() }()
    
    
    override func viewDidLoad() {
      
        super.viewDidLoad()
        title = "Profile"
        textFieldList = [phoneField.textField]
        dismissKeyboardAction = {
            [weak self]  field in
            guard let self = self else { return }
            self.phoneField.onIconClicked(sender: field)
        }
        self.nameField.titleLabel.text = "ФИО:"
        self.nameField.icon.isHidden = true
        self.emailField.titleLabel.text = "Email"
        self.emailField.icon.isHidden = true
        self.phoneField.titleLabel.text = "Телефон:"
        self.phoneField.icon.isHidden = false
        self.phoneField.textField.keyboardType = .numberPad
        self.birthDateField.titleLabel.text = "День рождения:"
        self.birthDateField.icon.isHidden = true
        self.employedDateField.titleLabel.text = "Дата устройства:"
        self.employedDateField.icon.isHidden = true
        self.seniorityField.titleLabel.text = "Стаж:"
        self.seniorityField.icon.isHidden = true
    }

    override func bind() {
        viewModel.onDataLoaded = {
            [weak self]  data in
            guard let self = self else { return }
            self.nameField.textField.text = data?.fullName
            self.emailField.textField.text = data?.email
            self.phoneField.textField.text = data?.phone
            self.birthDateField.textField.text = data?.birthDate.toString()
            self.employedDateField.textField.text = data?.employedDate.toString()
            self.seniorityField.textField.text = Date.calculateTimeDifference(from: data?.employedDate)
    
        }
    }
}
