//
//  ExpenseRemoteDataService.swift
//  bms
//
//  Created by Artem Tischenko on 10.08.2020.
//  Copyright © 2020 Artem Tischenko. All rights reserved.
//

import Alamofire

class ExpenseRemoteDataService: BaseRemoteDataService, ExpenseProtocol {
    
    func getAll(year: Int, completionHandler: @escaping ([ExpenseObject]) -> Void, errorHandler: ((String) -> Void)?) {
        ex(url: EndPoints.getExpenses,
           parameters: ["year": String(year)],
           completionHandler: completionHandler,
           errorHandler: errorHandler)
    }
    
    func getById(guid: String,
                 completionHandler: @escaping (ExpenseDetailObject) -> Void,
                 errorHandler: ((String) -> Void)?) {
        ex(url: EndPoints.getExpenseByGuid,
           parameters: ["expenseId": guid],
           completionHandler: completionHandler,
           errorHandler: errorHandler)
    }
    
    func removeById(guid: String, completionHandler: @escaping () -> Void, errorHandler: ((String) -> Void)?) {
        ex(url: EndPoints.postDeleteExpense,
           method: .delete,
           parameters: ["expenseId": guid],
           encoding: URLEncoding.queryString,
           completionHandler: completionHandler,
           errorHandler: errorHandler)
    }
    
    func addOrUpdate(expense: ExpenseDetailObject,
                     completionHandler: @escaping () -> Void,
                     errorHandler: ((String) -> Void)?) {
        ex(url: EndPoints.postExpenseAddOrUpdate,
           body: expense,
           method: .post,
           completionHandler: completionHandler,
           errorHandler: errorHandler)
    }
}
