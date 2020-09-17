//
//  AccountRemoteDataService.swift
//  bms
//
//  Created by Sergey on 14.08.2020.
//  Copyright © 2020 Artem Tischenko. All rights reserved.
//

import Foundation
import Alamofire

class UserRemoteDataService: BaseRemoteDataService, UserProtocol {
    
    func login(login: String,
               password: String,
               completionHandler: @escaping (LoginResponseObject) -> Void,
               errorHandler: ((String) -> Void)?) {
        ex(url: EndPoints.postLogin,
           method: .post,
           parameters: ["username": login, "password": password],
           encoding: JSONEncoding.default,
           converter: LoginResponseDto.toObject,
           completionHandler: completionHandler,
           errorHandler: errorHandler)
    }
    
    func getUserInfo(completionHandler: @escaping (UserInfoObject) -> Void,
                     errorHandler: ((String) -> Void)?) {
         ex(url: EndPoints.getUserInfo,
            converter: UserInfoDto.toObject,
            completionHandler: completionHandler,
            errorHandler: errorHandler)
    }
    
    func updateUserInfo(userInfoForUpdate: UserInfoForUpdateObject,
                        completionHandler: @escaping () -> Void,
                        errorHandler: ((String) -> Void)?) {
        ex(url: EndPoints.postUpdateUserInto,
           body: userInfoForUpdate,
           method: .post,
           completionHandler: completionHandler,
           errorHandler: errorHandler)
    }
}
