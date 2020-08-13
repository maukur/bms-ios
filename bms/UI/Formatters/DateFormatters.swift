//
//  DateFormatters.swift
//  bms
//
//  Created by Artem Tischenko on 10.08.2020.
//  Copyright © 2020 Artem Tischenko. All rights reserved.
//

import Foundation

extension String {
    
    private static let dateFomatter = DateFormatter()
    
    func toDate() -> Date {
        String.self.dateFomatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return String.self.dateFomatter.date(from:self)!
    }
}
extension Int {
    func toString() -> String {
        return String(self)
    }
}
extension Date {
    private static let dateFomatter = DateFormatter()
    enum format {
        case date
        case dateTime
    }
    
    func toString (_ format: format = .date)->String {
        switch format {
        case .date:
            Date.self.dateFomatter.dateFormat = "dd/MM/yyyy"
        case .dateTime:
            Date.self.dateFomatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        }
        return Date.self.dateFomatter.string(from: self)
    }
    
    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
     
}
 
