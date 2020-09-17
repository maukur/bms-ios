//
//  ExpenseDetailDto.swift
//  bms
//
//  Created by Sergey on 17.09.2020.
//  Copyright © 2020 Artem Tischenko. All rights reserved.
//

import Foundation

struct ExpenseDetailDto: Codable {
    let id: String
    let description: String
    let date: Date
    let amount: Double
    let expenseCategoryId: String
    let currencyId: String
    let paymentMethodId: String
    let image: Data?
    let status: StatusEnum
}
