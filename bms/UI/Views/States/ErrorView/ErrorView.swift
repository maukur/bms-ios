//
//  ErrorView.swift
//  bms
//
//  Created by Artem Tischenko on 27.08.2020.
//  Copyright © 2020 Artem Tischenko. All rights reserved.
//

import UIKit

class ErrorView: UIView {
    
     @IBOutlet weak var errorLabel: UILabel! {
             didSet {
                errorLabel.textColor = .red
                errorLabel.text = "Error while data loading"
             }
         }
    @IBAction func retryButtonAction(_ sender: Any) {
        let ep = self.superview?.parentViewController as! ErrorProtocol
        ep.retryAction()
    }
}
