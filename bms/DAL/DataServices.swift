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

    static func initialize (isMock:Bool, baseUrl:String){
        if(isMock){
            userDataService = UserMockDataService()
            expenseDataService = ExpenseMockDataService()
        }
        else {
            let urlSession = URLSession(configuration: URLSessionConfiguration.default)
            userDataService = UserMockDataService()
            expenseDataService = ExpenseRemoteDataService(baseUrl: baseUrl, session: urlSession)

        }
        
    }
}
