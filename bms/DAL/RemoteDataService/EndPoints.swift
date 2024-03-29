//
//  endPoints.swift
//  OrderKing
//
//  Created by Artem Tischenko on 21.05.2020.
//  Copyright © 2020 Artem Tischenko. All rights reserved.
//

import Foundation

class EndPoints {
        
    static let getExpenseByGuid = "/MobileApi/Expenses/GetById"
    static let getExpenses = "/MobileApi/Expenses"
    static let postDeleteExpense = "/MobileApi/Expenses/Delete"
    static let getCategoryList = "/MobileApi/Expenses/ExpenseCategoryList"
    static let getCurrenciesList = "/MobileApi/Expenses/CurrencyList"
    static let getPaymentTypeList = "/MobileApi/Expenses/PaymentMethodList"
    static let getEventList = "/MobileApi/EventLogs"
    static let getUserInfo = "/MobileApi/Account/Info"
    static let postLogin = "/MobileApi/Account/Authenticate"
    static let postExpenseAddOrUpdate = "/MobileApi/Expenses/SaveOrUpdate"
    static let getEventCategoryList = "/MobileApi/EventLogs/EventCategoryList"
    static let postEventAddOrUpdate = "/MobileApi/EventLogs/SaveOrUpdate"
    static let getEventsByDate = "/MobileApi/EventLogs/GetEventLogsByDate"
    static let getEventDetailById = "/MobileApi/EventLogs/GetById"
    static let postDeleteEventById = "/MobileApi/EventLogs/Delete"
    static let postUpdateUserInto = "/MobileApi/Account/Update"
}
