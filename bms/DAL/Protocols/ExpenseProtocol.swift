//
//  ExpenseProtocol.swift
//  bms
//
//  Created by Artem Tischenko on 27.07.2020.
//  Copyright © 2020 Artem Tischenko. All rights reserved.
//

import Foundation

protocol ExpenseProtocol {
    func getAll(token: String, year:Int) -> RequestResult<[ExpenseGroupObject]> 


    func getById(guid:String) -> RequestResult<ExpenseDetailObject>
    
    func getCategories() -> RequestResult<[ExpenseCategoryObject]>
    func getCurrencies() -> RequestResult<[CurrencyObject]>
    func getPaymentTypes() -> RequestResult<[PaymentTypeObject]>
}
