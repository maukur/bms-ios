//
//  ExpenseRemoteDataService.swift
//  bms
//
//  Created by Artem Tischenko on 10.08.2020.
//  Copyright © 2020 Artem Tischenko. All rights reserved.
//

import Foundation

class ExpenseRemoteDataService: BaseRemoteDataService,ExpenseProtocol {
   
    func getAll(token: String, year:Int) -> RequestResult<[ExpenseGroupObject]> {
        let request = self.GET(url: EndPoints.getExpenses, parameters: ["year": String(year)])
           return execute(request)
    }
    
    func getCategories() -> RequestResult<[ExpenseCategoryObject]> {
        let request = self.GET(url: EndPoints.getCategoryList)
              return self.execute(request);
    }
    
    func getCurrencies() -> RequestResult<[CurrencyObject]> {
        let request = self.GET(url: EndPoints.getCurrenciesList)
              return self.execute(request);
    }
    
    func getPaymentTypes() -> RequestResult<[PaymentTypeObject]> {
        let request = self.GET(url: EndPoints.getPaymentTypeList)
              return self.execute(request);
    }
    
     
    
    func getById(guid: String) -> RequestResult<ExpenseDetailObject> {
        let request = self.GET(url: EndPoints.getExpenseByGuid, parameters: ["id" : guid])
        return self.execute(request);
    }
    
    
}
