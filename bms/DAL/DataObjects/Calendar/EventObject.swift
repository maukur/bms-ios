//
//  EventObject.swift
//  bms
//
//  Created by Artem Tischenko on 13.08.2020.
//  Copyright © 2020 Artem Tischenko. All rights reserved.
//

import Foundation

struct EventObject:Codable {
    let id: String
    let typeId: String
    let title: String
    let startDate: Date
    let endDate:Date
}
