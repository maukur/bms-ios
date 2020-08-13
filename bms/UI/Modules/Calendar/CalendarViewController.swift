//
//  CalendarViewController.swift
//  bms
//
//  Created by Artem Tischenko on 12.08.2020.
//  Copyright © 2020 Artem Tischenko. All rights reserved.
//

import JTAppleCalendar
import UIKit

class CalendarViewController: BaseViewController {
    
    @IBOutlet weak var calendar: JTACMonthView!
    
    override func viewDidLoad() {
        self.title = "Calendar"
        var x = calendar
        self.calendar.calendarDataSource = self
        self.calendar.calendarDelegate = self
        self.tabBarController?.tabBar.items![1].image = UIImage(named: "calendar")
        super.viewDidLoad()
    }
}
class DateCell: JTACDayCell {
    @IBOutlet var dateLabel: UILabel!
}

extension CalendarViewController: JTACMonthViewDataSource {
    func configureCalendar(_ calendar: JTACMonthView) -> ConfigurationParameters {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM dd"
        let startDate = formatter.date(from: "2018 01 01")!
        let endDate = Date()
        return ConfigurationParameters(startDate: startDate, endDate: endDate)
    }
}

extension CalendarViewController: JTACMonthViewDelegate {
    func calendar(_ calendar: JTACMonthView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTACDayCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "dateCell", for: indexPath) as! DateCell
        cell.dateLabel.text = cellState.text
        if(
            date.get(.weekday, calendar: .current) == 6
            ||
            date.get(.weekday, calendar: .current) == 7
            ){
            cell.layer.backgroundColor = UIColor.red.cgColor
        }
        else {
            cell.layer.backgroundColor = UIColor.yellow.cgColor }
        cell.layer.cornerRadius = cell.layer.bounds.height/2
        
        return cell
    }
    func calendar(_ calendar: JTACMonthView, willDisplay cell: JTACDayCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        let cell = cell as! DateCell
        cell.dateLabel.text = cellState.text
    }
}
