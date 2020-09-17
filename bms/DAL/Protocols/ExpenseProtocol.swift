//
//  ExpenseProtocol.swift
//  bms
//
//  Created by Artem Tischenko on 27.07.2020.
//  Copyright © 2020 Artem Tischenko. All rights reserved.
//

import Foundation

protocol ExpenseProtocol {
    
    func getAll(year: Int,
                completionHandler: @escaping ([ExpenseObject]) -> Void,
                errorHandler: ((String) -> Void)?)
    
    func getById(guid: String,
                 completionHandler: @escaping (ExpenseDetailObject) -> Void,
                 errorHandler: ((String) -> Void)?)
    
    func removeById(guid: String,
                    completionHandler: @escaping () -> Void,
                    errorHandler: ((String) -> Void)?)
    
    func addOrUpdate(expense: ExpenseDetailObject,
                     completionHandler: @escaping () -> Void,
                     errorHandler: ((String) -> Void)?)
}
