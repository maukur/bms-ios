//
//  User.swift
//  OrderKing
//
//  Created by Artem Tischenko on 14.05.2020.
//  Copyright © 2020 Artem Tischenko. All rights reserved.
//

import Foundation

protocol UserProtocol {
    
    func login(login: String,
               password: String,
               completionHandler: @escaping (LoginResponseObject) -> Void,
               errorHandler: ((String) -> Void)?)
    func getUserInfo(completionHandler: @escaping (UserInfoObject) -> Void,
                     errorHandler: ((String) -> Void)?)
    func updateUserInfo(userInfoForUpdate: UserInfoForUpdateObject,
                        completionHandler: @escaping () -> Void,
                        errorHandler: ((String) -> Void)?)
}
