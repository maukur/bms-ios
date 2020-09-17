//
//  EventDetailDto.swift
//  bms
//
//  Created by Sergey on 17.09.2020.
//  Copyright © 2020 Artem Tischenko. All rights reserved.
//

import Foundation

struct EventDetailDto: Codable {
    var id: String
    var eventCategoryId: String
    var reason: String
    var startDate: Date
    var endDate: Date?
    var status: StatusEnum
}
