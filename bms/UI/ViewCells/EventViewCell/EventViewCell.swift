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
    @IBOutlet weak var eventTypeLabel: UILabel!{
        didSet{
            eventTypeLabel.applayStyle(Styles.Labels.placeholderLabel(view:))
        }
    }
    @IBOutlet weak var eventStatusView: UIView!
    @IBOutlet weak var container: UIView!{
        didSet{
            container.applayStyle(Styles.UIViews.shadowUIView)
        }
    }
    

    func getColorByStatus(status: StatusEnum) -> UIColor {
        switch status {
        case .created:
            return UIColor(red: 154/255, green: 196/255, blue: 248/244, alpha: 1.0)
        case .approved:
            return UIColor(red: 154/255, green: 237/255, blue: 204/244, alpha: 1.0)
        case .denied:
            return UIColor(red: 227/255, green: 101/255, blue: 136/244, alpha: 1.0)
        case .none:
            return UIColor(red: 227/255, green: 101/255, blue: 136/244, alpha: 1.0)
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
