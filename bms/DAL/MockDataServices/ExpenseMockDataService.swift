//
//  ExpenseMockDataService.swift
//  bms
//
//  Created by Sergey on 14.09.2020.
//  Copyright © 2020 Artem Tischenko. All rights reserved.
//

import Foundation

class ExpenseMockDataService: BaseMockDataService, ExpenseProtocol {
    func getAll(year: Int, completionHandler: @escaping ([ExpenseObject]) -> Void, errorHandler: ((String) -> Void)?) {
        makeRequestFromJson(fileName: "Expenses", completionHandler: completionHandler, errorHandler: errorHandler)
    }
    func getById(guid: String,
                 completionHandler: @escaping (ExpenseDetailObject) -> Void,
                 errorHandler: ((String) -> Void)?) {
        makeRequestFromJson(fileName: "GetExpenseById",
                            completionHandler: completionHandler,
                            errorHandler: errorHandler)
    }
    func removeById(guid: String, completionHandler: @escaping () -> Void, errorHandler: ((String) -> Void)?) {
        completionHandler()
    }
    func addOrUpdate(expense: ExpenseDetailObject,
                     completionHandler: @escaping () -> Void,
                     errorHandler: ((String) -> Void)?) {
        completionHandler()
    }
}
