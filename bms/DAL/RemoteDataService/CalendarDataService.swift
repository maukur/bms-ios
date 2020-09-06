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
	func getAllEvents(year: Int, completionHandler: @escaping ([Date]) -> (), errorHandler: ((String) -> ())?) {
		ex(url: EndPoints.getEventList, parameters: ["year": year], completionHandler: completionHandler, errorHandler: errorHandler)
	}

	func getEventTypeList(completionHandler: @escaping ([EventCategoryObject]) -> (), errorHandler: ((String) -> ())?) {
		ex(url: EndPoints.getEventCategoryList, completionHandler: completionHandler, errorHandler: errorHandler)
	}

	func addOrUpdate(event: EventDetailObject, completionHandler: @escaping () -> (), errorHandler: ((String) -> ())?) {
		ex(url: EndPoints.postEventAddOrUpdate, body: event, method: .post, completionHandler: completionHandler, errorHandler: errorHandler)
	}

	func getEventsByDate(date: Date, completionHandler: @escaping ([EventObject]) -> (), errorHandler: ((String) -> ())?) {
		ex(url: EndPoints.getEventsByDate, parameters: ["date": date], completionHandler: completionHandler, errorHandler: errorHandler)
	}

	func getEventDetailObjectById(guid: String, completionHandler: @escaping (EventDetailObject) -> (), errorHandler: ((String) -> ())?) {
		ex(url: EndPoints.getEventDetailById, parameters: ["eventLogId": guid], completionHandler: completionHandler, errorHandler: errorHandler)
	}

	func removeEventById(guid: String, completionHandler: @escaping () -> (), errorHandler: ((String) -> ())?){
		ex(url: EndPoints.postDeleteEventById, method: .post, parameters: ["eventLogId": guid], encoding: URLEncoding.queryString, completionHandler: completionHandler, errorHandler: errorHandler)
	}


}
