//
//  AddEventViewController.swift
//  bms
//
//  Created by Sergey on 20.08.2020.
//  Copyright © 2020 Artem Tischenko. All rights reserved.
//

import UIKit

class EventEditViewController: BaseViewController {
    
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
    
    @objc func handleStartDatePicker(_ datePicker: UIDatePicker) {
        startDateField.text = datePicker.date.toString()
        viewModel.didStartDateChange(date: datePicker.date)
    }
    @objc func handleEndDatePicker(_ datePicker: UIDatePicker) {
        endDateField.text = datePicker.date.toString()
        viewModel.didEndDateChange(date: datePicker.date)
    }
    @IBAction func onSaveButtonClicked(_ sender: Any) {
        viewModel.addOrUpdateEvent()
    }
    @IBAction func onCancelButtonClicked(_ sender: Any) {
        viewModel.navigateBack(mode: .modal)
    }
    @IBAction func descriptionTextChanged(_ sender: Any) {
        viewModel.didDescriptionTextChange(text: descriptionField.text!)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
            self.eventTypeField.text = self.viewModel.eventCategoryList!.first!.name
        }
    }

    
    func createEventTypePickerView(items:[EventCategoryObject]) {
        let pickerView = DefaultUIPickerView()
        let pickerSettings = getEventTypePickerDelegate(items: items)
        pickerView.setSettings(settings: pickerSettings)
        eventTypeField.inputView = pickerView
    }
    
    func getEventTypePickerDelegate(items:[EventCategoryObject]) ->  PickerSettings {
        let pickerDelegate = PickerSettings(
            items: items,
            numberOfComponents: 1,
            getDisplayValue:
            {
                value in
                let item = value as! EventCategoryObject
                return item.name
            },
            didSelectRow: {
                [weak self]
                value in
                let eventTypeObject = (value as? EventCategoryObject)
                self?.eventTypeField.text = eventTypeObject?.name
                self?.viewModel.didSelectEventType(item: eventTypeObject!)
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
