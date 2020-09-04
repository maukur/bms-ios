//
//  endPoints.swift
//  OrderKing
//
//  Created by Artem Tischenko on 21.05.2020.
//  Copyright © 2020 Artem Tischenko. All rights reserved.
//

import Foundation

class EndPoints {
        
    static let getExpenseByGuid = "/Mobile/GetExpenseById"
    static let getExpenses = "/Mobile/Expenses"
    static let postDeleteExpense = "/MobileApi​/Expenses​/Delete"

    
    static let getCategoryList = "/Mobile/CategoryList"
    static let getCurrenciesList = "/Mobile/CurrenciesList"
    static let getPaymentTypeList = "/Mobile/PaymentTypeList"
    static let getEventList = "/Mobile/Events"
    static let getUserInfo = "/Mobile/UserInfo"
    static let postLogin = "/MobileApi/Account/Authenticate"

    static let getEventTypeList = "/Mobile/EventTypeList"
}
