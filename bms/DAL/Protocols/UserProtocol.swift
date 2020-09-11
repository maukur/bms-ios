//
//  User.swift
//  OrderKing
//
//  Created by Artem Tischenko on 14.05.2020.
//  Copyright © 2020 Artem Tischenko. All rights reserved.
//

import Foundation

protocol UserProtocol {
    
    func login(login: String, password: String, completionHandler: @escaping (LoginResponseObject) -> (), errorHandler: ((String) -> ())?)
    func getUserInfo(completionHandler: @escaping (UserInfoObject) -> (), errorHandler: ((String) -> ())?)
    func updateUserInfo(userInfoForUpdate: UserInfoForUpdateObject, completionHandler: @escaping () -> (), errorHandler: ((String) -> ())?)
}
