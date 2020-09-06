//
//  EventProtocol.swift
//  bms
//
//  Created by Artem Tischenko on 14.08.2020.
//  Copyright © 2020 Artem Tischenko. All rights reserved.
//

import Foundation

protocol CalendarProtocol {
    func getAllEvents(year: Int, completionHandler: @escaping ([Date]) -> (), errorHandler: ((String) -> ())?)
    func getEventTypeList(completionHandler: @escaping ([EventCategoryObject]) -> (), errorHandler: ((String) -> ())?)
    func addOrUpdate(event:EventDetailObject, completionHandler: @escaping () -> (), errorHandler: ((String) -> ())?)
    func getEventsByDate(date: Date, completionHandler: @escaping ([EventObject]) -> (), errorHandler: ((String) -> ())?)
    func getEventDetailObjectById(guid: String, completionHandler: @escaping (EventDetailObject) -> (), errorHandler: ((String) -> ())?)
    func removeEventById(guid: String, completionHandler: @escaping () -> (), errorHandler: ((String) -> ())?)
}
