//
//  CachedDataService.swift
//  bms
//
//  Created by Artem Tischenko on 02.09.2020.
//  Copyright © 2020 Artem Tischenko. All rights reserved.
//

import Foundation

class CachedDataService:BaseRemoteDataService{
    
    private var cache = NSCache<NSString, NSArray>()

    override init(baseUrl: String, getToken: @escaping () -> String?) {
        super.init(baseUrl: baseUrl, getToken: getToken)
        ex(url: EndPoints.getCategoryList, completionHandler:  categoryCompletionHandler)
        ex(url: EndPoints.getPaymentTypeList, completionHandler: paymentCompletionHandler)
        ex(url: EndPoints.getCurrenciesList, completionHandler:  currencyCompletionHandler)
    }
    
    private func categoryCompletionHandler(result:[ExpenseCategoryObject])  {
        cache.setObject(result as NSArray, forKey: "expenseCategoryObject")
    }
    private func paymentCompletionHandler(result:[PaymentTypeObject])  {
        cache.setObject(result as NSArray, forKey: "paymentTypeObject")
    }
    private func currencyCompletionHandler(result:[CurrencyObject])  {
        cache.setObject(result as NSArray, forKey: "currencyObject")
    }
    
    func getExpenseCategoryList() -> [ExpenseCategoryObject] {
        return cache.object(forKey: "expenseCategoryObject") as! [ExpenseCategoryObject]
    }
    
    func getExpensePaymentList() -> [PaymentTypeObject] {
        return cache.object(forKey: "paymentTypeObject") as! [PaymentTypeObject]
    }
    
    func getExpenseCurrnecyList() -> [CurrencyObject] {
        return cache.object(forKey: "currencyObject") as! [CurrencyObject]
    }
}
