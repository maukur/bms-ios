//
//  ExpensesViewCell.swift
//  bms
//
//  Created by Artem Tischenko on 16.07.2020.
//  Copyright © 2020 Artem Tischenko. All rights reserved.
//

import UIKit

class ExpensesViewCell: UITableViewCell, InitializedViewCell {
    func initialize(item: Any) {
        let value = item as? ExpenseObject
        dayLabel.text = value?.date.get(.day).toString()
        descriptionLabel.text =  value?.description
        priceLabel.text =  String(value!.amount) + " Р"
    }
    
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.dayLabel.textColor = .white
    }
}

