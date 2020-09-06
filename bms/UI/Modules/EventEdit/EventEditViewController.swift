//
//  AddEventViewController.swift
//  bms
//
//  Created by Sergey on 20.08.2020.
//  Copyright © 2020 Artem Tischenko. All rights reserved.
//

import UIKit

class EventEditViewController: BaseViewController {

	private lazy var viewModel: EventEditViewModel = {
		getViewModel()
	}()

	@IBOutlet weak var eventTypeField: UITextField!
	@IBOutlet weak var descriptionField: UITextField!
	@IBOutlet weak var selectDateFormatSwitch: UISwitch!
	@IBOutlet weak var startDateField: UITextField!

	@IBOutlet weak var endDateLabel: UILabel!
	@IBOutlet weak var endDateField: UITextField!

	@IBOutlet weak var saveButton: UIButton!
	@IBOutlet weak var cancelButton: UIButton!


	func setEndDateState() {
		endDateField.isUserInteractionEnabled = selectDateFormatSwitch.isOn
		endDateLabel.textColor = selectDateFormatSwitch.isOn ? .black : .gray
		endDateField.textColor = selectDateFormatSwitch.isOn ? .black : .gray
		endDateField.isUserInteractionEnabled = selectDateFormatSwitch.isOn
	}

	@IBAction func onSelectDateFormatSwitchSwitched(_ sender: UISwitch) {
		setEndDateState()
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
		viewModel.addOrUpdateEvent(onlyStartDate: !self.selectDateFormatSwitch.isOn)
	}

	@IBAction func onCancelButtonClicked(_ sender: Any) {
		viewModel.navigateBack(mode: .modal)
	}

	@IBAction func descriptionTextChanged(_ sender: Any) {
		viewModel.didDescriptionTextChange(text: descriptionField.text!)
	}

	@objc func deleteButtonAction() {
		viewModel.deleteEvent()
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		selectDateFormatSwitch.isOn = false
		setEndDateState()
		startDateField.text = Date().toString()
		endDateField.text = Date().toString()
		setDatePickerView(target: startDateField, action: #selector(handleStartDatePicker))
		setDatePickerView(target: endDateField, action: #selector(handleEndDatePicker))
        doneTextFieldButton(textField: eventTypeField)
        doneTextFieldButton(textField: descriptionField)
        doneTextFieldButton(textField: startDateField)
        doneTextFieldButton(textField: endDateField)
	}

	func setReadOnlyState() {
		eventTypeField.isEnabled = false
		descriptionField.isEnabled = false
		selectDateFormatSwitch.isEnabled = false
		startDateField.isEnabled = false
		endDateField.isEnabled = false

	}

	override func bind() {
		viewModel.didLoadData = {
			[weak self] in

			let eventList = self?.viewModel.eventCategoryList
			self?.createEventTypePickerView(items: eventList!)
			self?.eventTypeField.text = self?.viewModel.eventCategoryList!.first!.name
			self?.descriptionField.text = self?.viewModel.event?.reason
			self?.startDateField.text = self?.viewModel.event?.startDate.toString()
			self?.endDateField.text = self?.viewModel.event?.endDate?.toString()

			if (self?.viewModel.event?.startDate.toString() != self?.viewModel.event?.endDate?.toString()) { //TODO
				self?.selectDateFormatSwitch.isOn = true;
				self?.setEndDateState()

			}
		}
		viewModel.didSetPageState = {
			[weak self] status in
			guard let self = self else {
				return
			}
			switch status {
			case .edit:
				self.title = "Редактирование события"
				let button = UIBarButtonItem(image: UIImage(named: "trash"), style: .plain, target: self, action: #selector(self.deleteButtonAction));
				self.navigationItem.rightBarButtonItems = [button]
				break
			case .new:
				self.title = "Добавление события"
				let button = UIBarButtonItem(image: UIImage(named: "cancel"), style: .plain, target: self, action: #selector(self.onCancelButtonClicked));
				self.navigationItem.rightBarButtonItems = [button]
				break
			case .readOnly:
				self.title = "Событие"
				let button = UIBarButtonItem(image: UIImage(named: "cancel"), style: .plain, target: self, action: #selector(self.onCancelButtonClicked));
				self.navigationItem.rightBarButtonItems = [button]
				self.saveButton.isHidden = true
				self.setReadOnlyState()
				break
			default:
				break
			}
		}
	}

	func createEventTypePickerView(items: [EventCategoryObject]) {
		let pickerView = DefaultUIPickerView()
		let pickerSettings = getEventTypePickerDelegate(items: items)
		pickerView.setSettings(settings: pickerSettings)
		eventTypeField.inputView = pickerView
	}

	func getEventTypePickerDelegate(items: [EventCategoryObject]) -> PickerSettings {
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