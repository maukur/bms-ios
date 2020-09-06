//
//  UserMockDataService.swift
//  OrderKing
//
//  Created by Artem Tischenko on 14.05.2020.
//  Copyright © 2020 Artem Tischenko. All rights reserved.
//

import Foundation

class UserMockDataService: BaseMockDataService, UserProtocol {
    func login(login: String, password: String, completionHandler: @escaping (LoginResponseObject) -> (), errorHandler: ((String) -> ())?) {
        
    }
    
    func getUserInfo(completionHandler: @escaping (UserInfoDto) -> (), errorHandler: ((String) -> ())?) {
            
    }

    func updateUserInfo(userInfoForUpdate: UserInfoForUpdateObject, completionHandler: @escaping () -> (), errorHandler: ((String) -> ())?) {

    }
}
