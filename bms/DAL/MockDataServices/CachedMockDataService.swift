//
//  CachedMockDataService.swift
//  bms
//
//  Created by Sergey on 14.09.2020.
//  Copyright © 2020 Artem Tischenko. All rights reserved.
//

import Foundation
class CachedMockDataService: BaseMockDataService, CachedProtocol {
    
    private var cache = NSCache<NSString, NSArray>()
    
    override init() {
        super.init()
        MakeRequestFromJson(fileName: "EventCategoryList", completionHandler: eventCategoryCompletionHandler)
        MakeRequestFromJson(fileName: "ExpenseCategoryList", completionHandler: expenseCategoryCompletionHandler)
        MakeRequestFromJson(fileName: "PaymentMethodList", completionHandler: paymentCompletionHandler)
        MakeRequestFromJson(fileName: "CurrencyList", completionHandler: currencyCompletionHandler)
        
    }
    
    private func eventCategoryCompletionHandler(result:[EventCategoryObject])  {
        cache.setObject(result as NSArray, forKey: "eventCategoryObject")
    }
    private func expenseCategoryCompletionHandler(result:[ExpenseCategoryObject])  {
        cache.setObject(result as NSArray, forKey: "expenseCategoryObject")
    }
    private func paymentCompletionHandler(result:[PaymentTypeObject])  {
        cache.setObject(result as NSArray, forKey: "paymentTypeObject")
    }
    private func currencyCompletionHandler(result:[CurrencyObject])  {
        cache.setObject(result as NSArray, forKey: "currencyObject")
    }
    
    
    func getExpenseCategoryList() -> [ExpenseCategoryObject] {
        cache.object(forKey: "expenseCategoryObject") as? [ExpenseCategoryObject] ?? []
    }
    
    func getExpensePaymentList() -> [PaymentTypeObject] {
        cache.object(forKey: "paymentTypeObject") as? [PaymentTypeObject] ?? []
    }
    
    func getExpenseCurrencyList() -> [CurrencyObject] {
        cache.object(forKey: "currencyObject") as? [CurrencyObject] ?? []
    }
    
    func getEventCategoryList() -> [EventCategoryObject] {
        cache.object(forKey: "eventCategoryObject") as? [EventCategoryObject] ?? []
    }
}
