//
//  ExpenseProtocol.swift
//  bms
//
//  Created by Artem Tischenko on 27.07.2020.
//  Copyright © 2020 Artem Tischenko. All rights reserved.
//

import Foundation

protocol ExpenseProtocol {
    
    
    func getAll(year: Int, completionHandler: @escaping ([ExpenseGroupObject]) -> (), errorHandler: ((String) -> ())?)
    func getCategories(year: Int, completionHandler: @escaping ([ExpenseCategoryObject]) -> (), errorHandler: ((String) -> ())?)
    func getCurrencies(token: String, completionHandler: @escaping ([CurrencyObject]) -> (), errorHandler: ((String) -> ())?)
    func getPaymentTypes(completionHandler: @escaping ([PaymentTypeObject]) -> (), errorHandler: ((String) -> ())?)
    func getById(guid: String, completionHandler: @escaping (ExpenseDetailObject) -> (), errorHandler: ((String) -> ())?)
    
}
