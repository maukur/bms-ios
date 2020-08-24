//
//  EventProtocol.swift
//  bms
//
//  Created by Artem Tischenko on 14.08.2020.
//  Copyright © 2020 Artem Tischenko. All rights reserved.
//

import Foundation

protocol CalendarProtocol {
    func getAllEvents(completionHandler: @escaping ([EventObject]) -> (), errorHandler: ((String) -> ())?)
    func getEventTypeList(completionHandler: @escaping ([EventTypeObject]) -> (), errorHandler: ((String) -> ())?)
}
