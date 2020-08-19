//
//  ExpenseRemoteDataService.swift
//  bms
//
//  Created by Artem Tischenko on 10.08.2020.
//  Copyright © 2020 Artem Tischenko. All rights reserved.
//

import Foundation

class ExpenseRemoteDataService: BaseRemoteDataService,ExpenseProtocol {
    func getAll(year: Int, completionHandler: @escaping ([ExpenseGroupObject]) -> (), errorHandler: ((String) -> ())?) {
        ex(url: EndPoints.getExpenses, parameters: ["year": String(year)], completionHandler: completionHandler, errorHandler: errorHandler)
    }
    
    func getCategories(year: Int, completionHandler: @escaping ([ExpenseCategoryObject]) -> (), errorHandler: ((String) -> ())?) {
        ex(url: EndPoints.getCategoryList, completionHandler: completionHandler, errorHandler: errorHandler)
    }
    
    func getCurrencies(token: String, completionHandler: @escaping ([CurrencyObject]) -> (), errorHandler: ((String) -> ())?) {
        ex(url: EndPoints.getCurrenciesList, completionHandler: completionHandler, errorHandler: errorHandler)
    }
    func getPaymentTypes(completionHandler: @escaping ([PaymentTypeObject]) -> (), errorHandler: ((String) -> ())?) {
        ex(url: EndPoints.getPaymentTypeList, completionHandler: completionHandler, errorHandler: errorHandler)
    }
    func getById(guid: String, completionHandler: @escaping (ExpenseDetailObject) -> (), errorHandler: ((String) -> ())?) {
        ex(url: EndPoints.getExpenseByGuid, parameters: ["id" : guid], completionHandler: completionHandler, errorHandler: errorHandler)
    }
    
    
    
    
    
    
    
}
