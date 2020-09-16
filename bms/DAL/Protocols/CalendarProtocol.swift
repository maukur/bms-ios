//
//  EventProtocol.swift
//  bms
//
//  Created by Artem Tischenko on 14.08.2020.
//  Copyright © 2020 Artem Tischenko. All rights reserved.
//

import Foundation

protocol CalendarProtocol {
    func getAllEvents(year: Int,
                      completionHandler: @escaping ([Date]) -> Void,
                      errorHandler: ((String) -> Void)?)
    func getEventTypeList(completionHandler: @escaping ([EventCategoryObject]) -> Void,
                          errorHandler: ((String) -> Void)?)
    func addOrUpdate(event:eventDetailObject,
                     completionHandler: @escaping () -> Void,
                     errorHandler: ((String) -> Void)?)
    func getEventsByDate(date: Date,
                         completionHandler: @escaping ([EventObject]) -> Void,
                         errorHandler: ((String) -> Void)?)
    func getEventDetailObjectById(guid: String,
                                  completionHandler: @escaping (eventDetailObject) -> Void,
                                  errorHandler: ((String) -> Void)?)
    func removeEventById(guid: String,
                         completionHandler: @escaping () -> Void,
                         errorHandler: ((String) -> Void)?)
}
