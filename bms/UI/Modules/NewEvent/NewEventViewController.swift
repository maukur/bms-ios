//
//  AddEventViewController.swift
//  bms
//
//  Created by Sergey on 20.08.2020.
//  Copyright © 2020 Artem Tischenko. All rights reserved.
//

import UIKit

class NewEventViewController: BaseViewController {
 
    private lazy var viewModel: NewEventViewModel = { getViewModel() }()
    
    @IBOutlet weak var eventTypeField: UITextField!
    @IBOutlet weak var descriptionField: UITextField!
    @IBOutlet weak var selectDateFormatSwitch: UISwitch!
    @IBOutlet weak var startDateField: UITextField!
    
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var endDateField: UITextField!
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    
    @IBAction func onSelectDateFormatSwitchSwitched(_ sender: UISwitch) {
        endDateField.isUserInteractionEnabled = selectDateFormatSwitch.isOn
        endDateLabel.textColor = selectDateFormatSwitch.isOn ? .black : .gray
        endDateField.textColor = selectDateFormatSwitch.isOn ? .black : .gray
    }
    @IBAction func onSaveButtonClicked(_ sender: Any) {
        
    }
    @IBAction func onCancelButtonClicked(_ sender: Any) {

    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldList = [eventTypeField, descriptionField, startDateField, endDateField]
        selectDateFormatSwitch.isOn = false
        endDateField.isUserInteractionEnabled = false
        endDateLabel.textColor = .gray
        endDateField.textColor = .gray
        startDateField.text = Date().toString()
        endDateField.text = Date().toString()
        setDatePickerView(target: startDateField, action: #selector(handleStartDatePicker))
        setDatePickerView(target: endDateField, action: #selector(handleEndDatePicker))
        
    
    }
    override func bind() {
        viewModel.onEventTypListLoaded = {
        [weak self]  data in
        guard let self = self else { return }
        
            self.createEventTypePickerView(items: data)
            self.eventTypeField.text = self.viewModel.eventTypeList.first?.name
        }
    }
    
    @objc func handleStartDatePicker(_ datePicker: UIDatePicker) {
        startDateField.text = datePicker.date.toString()
       }
    @objc func handleEndDatePicker(_ datePicker: UIDatePicker) {
        startDateField.text = datePicker.date.toString()
       }
    
    
    
    func createEventTypePickerView(items:[EventTypeObject]) {
          let pickerView = DefaultUIPickerView()
          let pickerSettinngs = getEventTypePickerDelegate(items: items)
          pickerView.setSettings(settings: pickerSettinngs)
          eventTypeField.inputView = pickerView
      }
    
    func getEventTypePickerDelegate(items:[EventTypeObject]) ->  PickerSettings {
           let pickerDelegate = PickerSettings(
               items: items,
               numberOfComponents: 1,
               getDisplayValue:
               {
                   value in
                   let item = value as! EventTypeObject
                   return item.name
           },
               didSelectRow: {
                 [weak self]
                 value in
                self?.eventTypeField.text = (value as? EventTypeObject)?.name
           })
           return pickerDelegate
       }
    
    func setDatePickerView(target: UITextField, action: Selector) {
           let pickerView = UIDatePicker()
           pickerView.datePickerMode = .date
           pickerView.addTarget(self, action: action, for: .valueChanged)
           target.inputView = pickerView
       }
}
