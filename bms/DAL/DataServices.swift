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
    static private(set) var cachedDataService: CachedDataService?

    static func initialize (isMock:Bool, baseUrl:String, getToken: @escaping ()->String?, unautorized: @escaping ()->()){
        if(isMock){
            userDataService = UserMockDataService()
         }
        else {
            userDataService = UserRemoteDataService(baseUrl: baseUrl, unauthorized: unautorized, getToken: getToken)
            expenseDataService = ExpenseRemoteDataService(baseUrl: baseUrl, unauthorized: unautorized, getToken: getToken)
            calendarDataService = CalendarDataService(baseUrl: baseUrl, unauthorized: unautorized, getToken: getToken)
        }
        cachedDataService = CachedDataService(baseUrl: baseUrl, unauthorized: unautorized, getToken: getToken)
    }
}
