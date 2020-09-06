//
//  ExpenseEditViewController.swift
//  bms
//
//  Created by Artem Tischenko on 03.08.2020.
//  Copyright © 2020 Artem Tischenko. All rights reserved.
//

import UIKit

class ExpenseEditViewController: BaseViewController
{
    @IBOutlet weak var pickerCategoryTextField: UITextField!
    @IBOutlet weak var datePickerTextField: UITextField!
    @IBOutlet weak var paymentTypeTextField: UITextField!
    @IBOutlet weak var currencyTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var createPhotoButton: UIButton!
    @IBOutlet weak var selectPhotoButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var descriptionTextField: UITextField!
    
    private lazy var viewModel: ExpenseEditViewModel = { getViewModel() }()
    
    override func bind() {
        
        viewModel.onSetCategories = { [weak self]
            items in
            guard let self = self else { return }
            self.createCategoryPickerView(items:items)
        }
        viewModel.onSetCurrencies = { [weak self]
            items in
            guard let self = self else { return }
            self.createCurrencyPickerView(items:items)
        }
        viewModel.onSetPaymentTypes = { [weak self]
            items in
            guard let self = self else { return }
            self.createPaymentTypePickerView(items:items)
        }
        
        viewModel.onSetCurrentDate = { [weak self]
            date in
            guard let self = self else { return }
            self.datePickerTextField.text = date.toString()
        }
        
        viewModel.onSetCurrentCategory = { [weak self]
            value in
            guard let self = self else { return }
            self.pickerCategoryTextField.text = value.name
        }
        viewModel.onSetCurrentCurrency = { [weak self]
            value in
            guard let self = self else { return }
            self.currencyTextField.text = value.name
        }
        viewModel.onSetCurrentPaymentType = { [weak self]
            value in
            guard let self = self else { return }
            self.paymentTypeTextField.text = value.name
        }
        viewModel.onSetCurrentItem = { [weak self]
            value in
            guard let self = self else { return }
            self.descriptionTextField.text = value.description
            self.priceTextField.text = String(value.amount)
            self.datePickerTextField.text =  value.date.toDate().toString()
            self.descriptionTextField.becomeFirstResponder()
        }
        viewModel.didSetPageState = {
            [weak self] status in
            guard let self = self else { return }
            switch status {
            case .edit:
                self.title = "Редактирование расходов"
                let button = UIBarButtonItem(image: UIImage(named: "trash"), style: .plain, target: self, action: #selector(self.deleteButtonAction));
                self.navigationItem.rightBarButtonItems = [button]
                break
            case .new:
                self.title = "Добавление расходов"
                let button = UIBarButtonItem(image: UIImage(named: "cancel"), style: .plain, target: self, action: #selector(self.cancelButtonAction));
                self.navigationItem.rightBarButtonItems = [button]
                break
            case .readOnly:
                self.title = "Расходы"
                let button = UIBarButtonItem(image: UIImage(named: "cancel"), style: .plain, target: self, action: #selector(self.cancelButtonAction));
                self.navigationItem.rightBarButtonItems = [button]
                self.setReadOnlyState()
                break
            default:
                break
            }
        }
        
    }
    
    @objc func deleteButtonAction(sender: Any)
    {
        viewModel.deleteItem()
    }
    
    @objc func cancelButtonAction(sender: Any)
    {
        viewModel.cancel()
    }
    
    func setReadOnlyState() {
        descriptionTextField.isEnabled = false
        priceTextField.isEnabled = false
        datePickerTextField.isEnabled = false
        pickerCategoryTextField.isEnabled = false
        currencyTextField.isEnabled = false
        paymentTypeTextField.isEnabled = false
        createPhotoButton.isHidden = true
        selectPhotoButton.isHidden = true
        saveButton.isHidden = true
    }
    
    func createCategoryPickerView(items:[ExpenseCategoryObject]) {
        let pickerView = DefaultUIPickerView()
        let pickerSettings = getCategoriesPickerDelegate(items: items)
        pickerView.setSettings(settings: pickerSettings)
        pickerCategoryTextField.inputView = pickerView
    }
    
    func createPaymentTypePickerView(items:[PaymentTypeObject]) {
        let pickerView = DefaultUIPickerView()
        let pickerSettings = getPaymentTypePickerDelegate(items: items)
        pickerView.setSettings(settings: pickerSettings)
        paymentTypeTextField.inputView = pickerView
    }
    
    func createCurrencyPickerView(items:[CurrencyObject]) {
        let pickerView = DefaultUIPickerView()
        let pickerSettings = getCurrencyPickerDelegate(items: items)
        pickerView.setSettings(settings: pickerSettings)
        currencyTextField.inputView = pickerView
    }
    
    func createDatePickerView() {
        let pickerView = UIDatePicker()
        pickerView.datePickerMode = .date
        pickerView.addTarget(self, action: #selector(handleDatePicker), for: .valueChanged)
        datePickerTextField.inputView = pickerView
    }
    
    @objc func handleDatePicker(_ datePicker: UIDatePicker) {
        viewModel.didSelectDate(date: datePicker.date)
    }
    
    func getCategoriesPickerDelegate(items:[ExpenseCategoryObject]) ->  PickerSettings {
        let pickerDelegate = PickerSettings(
            items: items,
            numberOfComponents: 1,
            getDisplayValue:
            {
                
                value in
                let item = value as! ExpenseCategoryObject
                return item.name
        },
            didSelectRow:
            {
                [weak self]
                value in
                let item = value as! ExpenseCategoryObject
                self?.viewModel.didSelectCategory(item:item)
        })
        return pickerDelegate
    }
    
    func getCurrencyPickerDelegate(items:[CurrencyObject]) ->  PickerSettings {
        let pickerDelegate = PickerSettings(
            items: items,
            numberOfComponents: 1,
            getDisplayValue:
            {
                value in
                let item = value as! CurrencyObject
                return item.name
        },
            didSelectRow:
            {
                [weak self]
                value in
                let item = value as! CurrencyObject
                self?.viewModel.didSelectCurrency(item : item)
        })
        return pickerDelegate
    }
    
    func getPaymentTypePickerDelegate(items:[PaymentTypeObject]) ->  PickerSettings {
        let pickerDelegate = PickerSettings(
            items: items,
            numberOfComponents: 1,
            getDisplayValue:
            {
                value in
                let item = value as! PaymentTypeObject
                return item.name
        },
            didSelectRow:
            {
                [weak self]
                value in
                let item = value as! PaymentTypeObject
                self?.viewModel.didSelectPaymentType(item:  item)
        })
        return pickerDelegate
    }
    
    @IBAction func getPhotoFromGalleryAction(_ sender: Any) {
        viewModel.getPhotoFromGallery()
        
    }
    @IBAction func getPhotoFromCameraAction(_ sender: Any) {
        viewModel.getPhotoFromCamera()
    }
    
    func doneTextFieldButton(textField:UITextField) {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.action))
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
    }
    
    @objc func action() {
        view.endEditing(true)
    }
    
    @IBAction func priceChanged(_ sender: UITextField) {
        let value = Double(sender.text!) ?? 0.0
        viewModel.didSelectPrice(value: value)
    }
    @IBAction func descriptionTextChanged(_ sender: UITextField) {
        viewModel.didSelectDescription(description: sender.text!)
    }
    @IBAction func saveAction(_ sender: Any) {
        viewModel.save()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createDatePickerView()
        doneTextFieldButton(textField: pickerCategoryTextField)
        doneTextFieldButton(textField: datePickerTextField)
        doneTextFieldButton(textField: currencyTextField)
        doneTextFieldButton(textField: descriptionTextField)
        doneTextFieldButton(textField: paymentTypeTextField)
        doneTextFieldButton(textField: priceTextField)
        priceTextField.keyboardType = .numberPad
    }
}
