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
        priceLabel.text =  String(Int(value!.amount)) + " ₽"
    }
    @IBOutlet weak var container: UIView! {
        didSet {
            container.applayStyle(Styles.UIViews.shadowUIView)
        }
    }
    @IBOutlet weak var descriptionLabel: UILabel! {
        didSet {
        }
    }
    @IBOutlet weak var dayLabel: UILabel! {
        didSet {
            dayLabel.applayStyle(Styles.Labels.dayLabel)
        }
    }
    @IBOutlet weak var priceLabel: UILabel! {
        didSet {
            //            container.layer.cornerRadius = 8
            //            container.layer.shadowColor = UIColor.black.cgColor
            //            container.layer.shadowOffset = CGSize(width: 0, height: 4.0)
            //            container.layer.shadowOpacity = 0.24
            //            container.layer.shadowRadius = CGFloat(4.0)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
