//
//  EventViewCell.swift
//  bms
//
//  Created by Artem Tischenko on 13.08.2020.
//  Copyright © 2020 Artem Tischenko. All rights reserved.
//

import UIKit

class EventViewCell: UITableViewCell, InitializedViewCell {
    func initialize(item: Any) {
        //let value = item as! EventObject
        //descriptionLabel.text =  value.title
        //descriptionLabel.font = .systemFont(ofSize: 12)
    }
    
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
