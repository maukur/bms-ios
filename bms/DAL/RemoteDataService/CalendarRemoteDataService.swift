//
//  CalendarDataService.swift
//  bms
//
//  Created by Artem Tischenko on 14.08.2020.
//  Copyright © 2020 Artem Tischenko. All rights reserved.
//

import Foundation
import Alamofire

class CalendarDataService: BaseRemoteDataService, CalendarProtocol {
    func getAllEvents(year: Int, completionHandler: @escaping ([Date]) -> Void, errorHandler: ((String) -> Void)?) {
        ex(url: EndPoints.getEventList,
           parameters: ["year": year],
           completionHandler: completionHandler,
           errorHandler: errorHandler)
    }
    func getEventTypeList(completionHandler: @escaping ([EventCategoryObject]) -> Void,
                          errorHandler: ((String) -> Void)?) {
        ex(url: EndPoints.getEventCategoryList, completionHandler: completionHandler, errorHandler: errorHandler)
    }
    func addOrUpdate(event: eventDetailObject,
                     completionHandler: @escaping () -> Void,
                     errorHandler: ((String) -> Void)?) {
        ex(url: EndPoints.postEventAddOrUpdate,
           body: event,
           method: .post,
           completionHandler: completionHandler,
           errorHandler: errorHandler)
    }
    func getEventsByDate(date: Date,
                         completionHandler: @escaping ([EventObject]) -> Void,
                         errorHandler: ((String) -> Void)?) {
        ex(url: EndPoints.getEventsByDate,
           parameters: ["date": date],
           completionHandler: completionHandler,
           errorHandler: errorHandler)
    }
    func getEventDetailObjectById(guid: String,
                                  completionHandler: @escaping (eventDetailObject) -> Void,
                                  errorHandler: ((String) -> Void)?) {
        ex(url: EndPoints.getEventDetailById,
           parameters: ["eventLogId": guid],
           completionHandler: completionHandler,
           errorHandler: errorHandler)
    }
    func removeEventById(guid: String,
                         completionHandler: @escaping () -> Void,
                         errorHandler: ((String) -> Void)?) {
        ex(url: EndPoints.postDeleteEventById,
           method: .delete,
           parameters: ["eventLogId": guid],
           encoding: URLEncoding.queryString,
           completionHandler: completionHandler,
           errorHandler: errorHandler)
    }
}
