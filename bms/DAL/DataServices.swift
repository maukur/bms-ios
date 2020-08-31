//
//  DataServices.swift
//  OrderKing
//
//  Created by Artem Tischenko on 14.05.2020.
//  Copyright © 2020 Artem Tischenko. All rights reserved.
//

import Foundation

class DataServices {
    
    static private(set) var userDataService: UserProtocol?
    static private(set) var expenseDataService: ExpenseProtocol?
    static private(set) var calendarDataService: CalendarProtocol?

    static func initialize (isMock:Bool, baseUrl:String, getToken: @escaping ()->String?){
        if(isMock){
            userDataService = UserMockDataService()
         }
        else {
            userDataService = UserRemoteDataService(baseUrl: baseUrl, getToken: getToken)
            expenseDataService = ExpenseRemoteDataService(baseUrl: baseUrl, getToken: getToken)
            calendarDataService = CalendarDataService(baseUrl: baseUrl, getToken: getToken)

        }
        
    }
}
