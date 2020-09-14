//
//  CachedProtocol.swift
//  bms
//
//  Created by Sergey on 14.09.2020.
//  Copyright © 2020 Artem Tischenko. All rights reserved.
//

import Foundation

protocol CachedProtocol {
    func getExpenseCategoryList() -> [ExpenseCategoryObject]
    
    func getExpensePaymentList() -> [PaymentTypeObject]
    
    func getExpenseCurrencyList() -> [CurrencyObject]

    func getEventCategoryList() -> [EventCategoryObject]
}
