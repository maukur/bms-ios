//
//  CalendarMockDataService.swift
//  bms
//
//  Created by Sergey on 14.09.2020.
//  Copyright © 2020 Artem Tischenko. All rights reserved.
//

import Foundation

class CalendarMockDataService: BaseMockDataService, CalendarProtocol {
    
    func getAllEvents(year: Int,
                      completionHandler: @escaping ([Date]) -> Void,
                      errorHandler: ((String) -> Void)?) {
        makeRequestFromJson(fileName: "EventsLogs", completionHandler: completionHandler, errorHandler: errorHandler)
    }
    
    func getEventTypeList(completionHandler: @escaping ([EventCategoryObject]) -> Void,
                          errorHandler: ((String) -> Void)?) {
        makeRequestFromJson(fileName: "EventCategoryList",
                            completionHandler: completionHandler,
                            errorHandler: errorHandler)
    }
    
    func addOrUpdate(event: EventDetailObject,
                     completionHandler: @escaping () -> Void,
                     errorHandler: ((String) -> Void)?) {
        completionHandler()
    }
    
    func getEventsByDate(date: Date,
                         completionHandler: @escaping ([EventObject]) -> Void,
                         errorHandler: ((String) -> Void)?) {
        makeRequestFromJson(fileName: "GetEventLogsByDate",
                            completionHandler: completionHandler,
                            errorHandler: errorHandler)
    }
    
    func getEventDetailObjectById(guid: String,
                                  completionHandler: @escaping (EventDetailObject) -> Void,
                                  errorHandler: ((String) -> Void)?) {
        makeRequestFromJson(fileName: "GetEventLogById",
                            completionHandler: completionHandler,
                            errorHandler: errorHandler)
    }
    
    func removeEventById(guid: String,
                         completionHandler: @escaping () -> Void,
                         errorHandler: ((String) -> Void)?) {
        completionHandler()
    }
}
