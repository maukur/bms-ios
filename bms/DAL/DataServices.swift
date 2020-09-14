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
    static private(set) var cachedDataService: CachedProtocol?
    
    static func initialize (isMock:Bool, baseUrl:String, getToken: @escaping ()->String?, unauthorized: @escaping ()->()){
        if(isMock){
            userDataService = UserMockDataService()
            expenseDataService = ExpenseMockDataService()
            calendarDataService = CalendarMockDataService()
            cachedDataService = CachedMockDataService() as CachedProtocol
            
        }
        else {
            userDataService = UserRemoteDataService(baseUrl: baseUrl, unauthorized: unauthorized, getToken: getToken)
            expenseDataService = ExpenseRemoteDataService(baseUrl: baseUrl, unauthorized: unauthorized, getToken: getToken)
            calendarDataService = CalendarDataService(baseUrl: baseUrl, unauthorized: unauthorized, getToken: getToken)
            cachedDataService = CachedDataService(baseUrl: baseUrl, unauthorized: unauthorized, getToken: getToken) as CachedProtocol
        }
        
    }
}
