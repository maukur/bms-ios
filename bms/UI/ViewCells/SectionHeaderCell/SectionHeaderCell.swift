//
//  SectionHeaderCell.swift
//  bms
//
//  Created by Artem Tischenko on 16.07.2020.
//  Copyright © 2020 Artem Tischenko. All rights reserved.
//

import UIKit

class SectionHeaderCell: UITableViewCell, InitializedViewCell {
    
    let dateFormatter =  DateFormatter()
    func initialize(item: Any) {
        let value = item as! Int
        label.text = dateFormatter.monthSymbols[value - 1]
    }
    
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .lightGray
    }
}
