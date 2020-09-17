//
// Created by Sergey on 06.09.2020.
// Copyright (c) 2020 Artem Tischenko. All rights reserved.
//

import Foundation

struct EventDetailObject: Codable {
    var id: String
    var eventCategoryId: String
    var reason: String
    var startDate: Date
    var endDate: Date?
    var status: StatusEnum
}
