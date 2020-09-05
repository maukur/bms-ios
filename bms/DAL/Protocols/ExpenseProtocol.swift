//
//  ExpenseProtocol.swift
//  bms
//
//  Created by Artem Tischenko on 27.07.2020.
//  Copyright © 2020 Artem Tischenko. All rights reserved.
//

import Foundation

protocol ExpenseProtocol {
    
    func getAll(year: Int, completionHandler: @escaping ([ExpenseObject]) -> (), errorHandler: ((String) -> ())?)
    func getById(guid: String, completionHandler: @escaping (ExpenseDetailObject) -> (), errorHandler: ((String) -> ())?)
    func removeById(guid: String, completionHandler: @escaping () -> (), errorHandler: ((String) -> ())?)
    func update (expense:ExpenseDetailObject, completionHandler: @escaping () -> (), errorHandler: ((String) -> ())?)
}
