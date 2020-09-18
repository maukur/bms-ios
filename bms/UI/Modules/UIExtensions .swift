//
// Created by Sergey on 06.09.2020.
// Copyright (c) 2020 Artem Tischenko. All rights reserved.
//

import UIKit

extension UIViewController {
    func doneTextFieldButton(textField: UITextField) {
        let toolBar = UIToolbar(frame: CGRect(origin: .zero, size: CGSize(width: view.frame.size.width, height: CGFloat(30))))
        let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.action))
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
        toolBar.sizeToFit()
    }
    @objc func action() {
        view.endEditing(true)
    }
}
