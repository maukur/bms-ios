//
//  CalendarMockDataService.swift
//  bms
//
//  Created by Sergey on 14.09.2020.
//  Copyright © 2020 Artem Tischenko. All rights reserved.
//

import Foundation

class CalendarMockDataService: BaseMockDataService, CalendarProtocol {
    func getAllEvents(year: Int, completionHandler: @escaping ([Date]) -> (), errorHandler: ((String) -> ())?) {
        MakeRequestFromJson(fileName: "EventsLogs", completionHandler: completionHandler, errorHandler: errorHandler)
    }
    
    func getEventTypeList(completionHandler: @escaping ([EventCategoryObject]) -> (), errorHandler: ((String) -> ())?) {
        MakeRequestFromJson(fileName: "EventCategoryList", completionHandler: completionHandler, errorHandler: errorHandler)
    }
    
    func addOrUpdate(event: EventDetailObject, completionHandler: @escaping () -> (), errorHandler: ((String) -> ())?) {
        completionHandler()
    }
    
    func getEventsByDate(date: Date, completionHandler: @escaping ([EventObject]) -> (), errorHandler: ((String) -> ())?) {
        MakeRequestFromJson(fileName: "GetEventLogsByDate", completionHandler: completionHandler, errorHandler: errorHandler)
    }
    
    func getEventDetailObjectById(guid: String, completionHandler: @escaping (EventDetailObject) -> (), errorHandler: ((String) -> ())?) {
        MakeRequestFromJson(fileName: "GetEventLogById", completionHandler: completionHandler, errorHandler: errorHandler)
    }
    
    func removeEventById(guid: String, completionHandler: @escaping () -> (), errorHandler: ((String) -> ())?) {
        completionHandler()
    }
}
