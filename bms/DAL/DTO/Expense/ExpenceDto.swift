//
//  ExpenceDto.swift
//  bms
//
//  Created by Artem Tischenko on 27.07.2020.
//  Copyright © 2020 Artem Tischenko. All rights reserved.
//

import Foundation

struct ExpenseDto: Codable {
    let Name:String
    let Date:String
    let Price: Double
    let Status: String
}
