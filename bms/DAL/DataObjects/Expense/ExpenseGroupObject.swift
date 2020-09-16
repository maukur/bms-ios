
//
//  ExpenseGroupOvject.swift
//  bms
//
//  Created by Artem Tischenko on 30.07.2020.
//  Copyright © 2020 Artem Tischenko. All rights reserved.
//

import Foundation

struct ExpenseGroupObject: Codable {
    let mounth: String
    let expenses: [ExpenseObject]
}
