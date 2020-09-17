//
//  ExpenseGroupDto.swift
//  bms
//
//  Created by Sergey on 17.09.2020.
//  Copyright © 2020 Artem Tischenko. All rights reserved.
//

import Foundation

struct ExpenseGroupDto: Codable {
    let mounth: String
    let expenses: [ExpenseObject]
}
