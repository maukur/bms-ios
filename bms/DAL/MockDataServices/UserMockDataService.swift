//
//  UserMockDataService.swift
//  OrderKing
//
//  Created by Artem Tischenko on 14.05.2020.
//  Copyright © 2020 Artem Tischenko. All rights reserved.
//

import Foundation

class UserMockDataService: BaseMockDataService, UserProtocol {
    func login(login: String,
               password: String,
               completionHandler: @escaping (LoginResponseObject) -> Void,
               errorHandler: ((String) -> Void)?) {
        makeRequestFromJson(fileName: "Authenticate",
                            completionHandler: completionHandler,
                            errorHandler: errorHandler)
    }
    func getUserInfo(completionHandler: @escaping (UserInfoObject) -> Void,
                     errorHandler: ((String) -> Void)?) {
        makeRequestFromJson(fileName: "Info",
                            completionHandler: completionHandler,
                            errorHandler: errorHandler)
    }
    func updateUserInfo(userInfoForUpdate: UserInfoForUpdateObject,
                        completionHandler: @escaping () -> Void,
                        errorHandler: ((String) -> Void)?) {
        completionHandler()
    }
}
