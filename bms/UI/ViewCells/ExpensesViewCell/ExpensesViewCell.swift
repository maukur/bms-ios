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
    
    @IBOutlet weak var container: UIView!
           {
           didSet{
               container.layer.cornerRadius = 8
               container.layer.shadowColor = UIColor.black.cgColor
               container.layer.shadowOffset = CGSize(width: 0, height: 4.0)
               container.layer.shadowOpacity = 0.24
               container.layer.shadowRadius = CGFloat(4.0)
           }
       }
    @IBOutlet weak var descriptionLabel: UILabel!
    {
        didSet{
           
        }
    }
    @IBOutlet weak var dayLabel: UILabel!
    {
        didSet{
            dayLabel.layer.shouldRasterize = true;
            dayLabel.layer.rasterizationScale = UIScreen.main.scale;
            dayLabel.layer.masksToBounds = true
            dayLabel.layer.cornerRadius = 6
            dayLabel.layer.shadowColor = UIColor.black.cgColor
            dayLabel.layer.shadowOffset = CGSize(width: 0, height: 10.0)
            dayLabel.layer.shadowOpacity = 0.24
            dayLabel.layer.shadowRadius = CGFloat(10.0)
            dayLabel.textColor = .white
        }
    }
    @IBOutlet weak var priceLabel: UILabel!
    {
        didSet{
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

