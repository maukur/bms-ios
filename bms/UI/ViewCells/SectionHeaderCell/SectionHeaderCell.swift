//
//  SectionHeaderCell.swift
//  bms
//
//  Created by Artem Tischenko on 16.07.2020.
//  Copyright © 2020 Artem Tischenko. All rights reserved.
//

import UIKit

class SectionHeaderCell: UITableViewCell, InitializedViewCell {
    
    
    
    func initialize(item: Any) {
        label.text = item as? String
    }
    
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .lightGray
    }
}
