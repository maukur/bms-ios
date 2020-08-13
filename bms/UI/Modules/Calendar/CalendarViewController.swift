//
//  CalendarViewController.swift
//  bms
//
//  Created by Artem Tischenko on 12.08.2020.
//  Copyright © 2020 Artem Tischenko. All rights reserved.
//

import KDCalendar
import UIKit

class CalendarViewController: BaseViewController{
   
    @IBOutlet weak var calendarView: CalendarView!
    
    override func viewDidLoad() {
        
        let today = Date()
        self.calendarView.setDisplayDate(today, animated: false)
        calendarView.direction = .horizontal
        calendarView.delegate = self
        calendarView.dataSource = self
        self.title = "Calendar"
        self.tabBarController?.tabBar.items![1].image = UIImage(named: "calendar")
        super.viewDidLoad()
    }
}



extension CalendarViewController:CalendarViewDataSource, CalendarViewDelegate
{
    func calendar(_ calendar: CalendarView, didScrollToMonth date: Date) {
        
    }
    
    func calendar(_ calendar: CalendarView, didSelectDate date: Date, withEvents events: [CalendarEvent]) {
        
    }
    
    func calendar(_ calendar: CalendarView, canSelectDate date: Date) -> Bool {
        return true
    }
    
    func calendar(_ calendar: CalendarView, didDeselectDate date: Date) {
        
    }
    
    func calendar(_ calendar: CalendarView, didLongPressDate date: Date, withEvents events: [CalendarEvent]?) {
    
    }
    
    func startDate() -> Date {
        let today = Date()
        return today
    }
    
    func endDate() -> Date {
        var dateComponents = DateComponents()
        dateComponents.year = +1
        let today = Date()
        let threeMonthsAgo = self.calendarView.calendar.date(byAdding: dateComponents, to: today)
        return threeMonthsAgo!
    }
    
    func headerString(_ date: Date) -> String? {
        return nil
    }
    
    
}
