//
//  EventViewCell.swift
//  bms
//
//  Created by Artem Tischenko on 13.08.2020.
//  Copyright © 2020 Artem Tischenko. All rights reserved.
//

import UIKit

class EventViewCell: UITableViewCell, InitializedViewCell {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var eventTypeLabel: UILabel!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var eventStatusView: UIView!
    

    func getColorByStatus(status: StatusEnum) -> UIColor {
        switch status {
        case .created:
             return .yellow
        case .approved:
            return .green
        case .denied:
            return .red
        case .none:
            return .red
        }

    }

    func initialize(item: Any) {
        let value = item as! EventObject

        descriptionLabel.text =  value.reason
        eventTypeLabel.text = value.type
        eventStatusView.backgroundColor = getColorByStatus(status: value.status)
/*
        startDateLabel.text = value.startDate.toString()
        endDateLabel.text = value.endDate.toString()
*/

    }

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
