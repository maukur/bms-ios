//
//  EventDto.swift
//  bms
//
//  Created by Sergey on 17.09.2020.
//  Copyright © 2020 Artem Tischenko. All rights reserved.
//

import Foundation

struct EventDto: Codable {
    var id: String
    var reason: String
    var type: String
    var status: StatusEnum
}
