//
//  CustomPicker.swift
//  bms
//
//  Created by Artem Tischenko on 05.08.2020.
//  Copyright © 2020 Artem Tischenko. All rights reserved.
//

import UIKit

class DefaultUIPickerView: UIPickerView, UIPickerViewDataSource, UIPickerViewDelegate {
    private var settings: PickerSettings?
    func setSettings(settings: PickerSettings) {
        self.settings = settings
        delegate = self
        dataSource = self
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return settings!.numberOfComponents
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return settings!.items.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return settings!.getDisplayValue!(settings!.items[row])
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        settings!.didSelectRow?(settings!.items[row])
        settings!.updateValue?(settings!.getDisplayValue!(settings!.items[row]))
    }
}

class PickerSettings {
      var items: [Any] = []
      var numberOfComponents = 1
      var getDisplayValue: ((Any) -> String)?
      var didSelectRow: ((Any) -> Void)?
      var updateValue: ((String) -> Void)?
    init(items: [Any], numberOfComponents: Int,
         getDisplayValue: ((Any) -> String)?,
         didSelectRow: ((Any) -> Void)?,
         updateValue: ((String) -> Void)? = nil) {
           self.items = items
           self.numberOfComponents = numberOfComponents
           self.getDisplayValue = getDisplayValue
           self.didSelectRow = didSelectRow
           self.updateValue = updateValue
       }
}
