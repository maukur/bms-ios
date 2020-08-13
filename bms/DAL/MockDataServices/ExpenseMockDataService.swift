//
//  Created by Artem Tischenko on 14.05.2020.
//  Copyright © 2020 Artem Tischenko. All rights reserved.
//

import Foundation

class ExpenseMockDataService: BaseMockDataService, ExpenseProtocol {
    func getAll(token: String, year: Int) -> RequestResult<[ExpenseGroupObject]> {
        return  RequestResult<[ExpenseGroupObject]>()
    }
    
    func getAll(token: String) -> RequestResult<[ExpenseGroupObject]> {
        return RequestResult<[ExpenseGroupObject]>()

    }
    
    func getCategories() -> RequestResult<[ExpenseCategoryObject]> {
        return RequestResult<[ExpenseCategoryObject]>()
    }
    
    func getCurrencies() -> RequestResult<[CurrencyObject]> {
    return RequestResult<[CurrencyObject]>()

    }
    
    func getPaymentTypes() -> RequestResult<[PaymentTypeObject]> {
        return RequestResult<[PaymentTypeObject]>()

    }
    
    func getById(guid: String) -> RequestResult<ExpenseDetailObject> {
        return RequestResult<ExpenseDetailObject>()
    }
    
    
}
