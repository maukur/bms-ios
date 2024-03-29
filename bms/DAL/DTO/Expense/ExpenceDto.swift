//
//  ExpenceDto.swift
//  bms
//
//  Created by Artem Tischenko on 27.07.2020.
//  Copyright © 2020 Artem Tischenko. All rights reserved.
//

import Foundation

struct ExpenseDto: Codable {
    let id: String
    let description: String
    let date: Date
    let amount: Double
    let status: StatusEnum
}
