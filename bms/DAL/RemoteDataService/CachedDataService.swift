//
//  CachedDataService.swift
//  bms
//
//  Created by Artem Tischenko on 02.09.2020.
//  Copyright © 2020 Artem Tischenko. All rights reserved.
//

import Foundation

class CachedDataService:BaseRemoteDataService, CachedProtocol{
    
    private var cache = NSCache<NSString, NSArray>()
    
    override init(baseUrl: String, unauthorized: @escaping () -> Void, getToken: @escaping () -> String?) {
        super.init(baseUrl: baseUrl, unauthorized: unauthorized, getToken: getToken)
        ex(url: EndPoints.getCategoryList, completionHandler:  categoryCompletionHandler)
        ex(url: EndPoints.getPaymentTypeList, completionHandler: paymentCompletionHandler)
        ex(url: EndPoints.getCurrenciesList, completionHandler:  currencyCompletionHandler)
        ex(url: EndPoints.getEventCategoryList, completionHandler: eventCategoryCompletionHandler)
    }
    private func eventCategoryCompletionHandler(result: [EventCategoryObject]) {
        cache.setObject(result as NSArray, forKey: "eventCategoryObject")
    }
    private func categoryCompletionHandler(result: [ExpenseCategoryObject]) {
        cache.setObject(result as NSArray, forKey: "expenseCategoryObject")
    }
    private func paymentCompletionHandler(result: [PaymentTypeObject]) {
        cache.setObject(result as NSArray, forKey: "paymentTypeObject")
    }
    private func currencyCompletionHandler(result: [CurrencyObject]) {
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
