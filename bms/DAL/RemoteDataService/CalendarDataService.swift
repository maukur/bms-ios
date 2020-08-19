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
    func getAllEvents(token: String, completionHandler: @escaping ([EventObject]) -> (), errorHandler:  ((String) -> ())?) {
        ex(url:  EndPoints.getEventList, completionHandler: completionHandler, errorHandler: errorHandler)
        
     }
}
