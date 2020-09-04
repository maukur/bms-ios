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
   
    func login(login: String, password: String, completionHandler: @escaping (LoginResponseObject) -> (), errorHandler: ((String) -> ())?) {
        ex(url: EndPoints.postLogin, method: .post, parameters: ["username": login, "password":password],  encoding: JSONEncoding.default, completionHandler: completionHandler, errorHandler: errorHandler)
    }
    
    func getUserInfo(completionHandler: @escaping (UserInfoDto) -> (), errorHandler: ((String) -> ())?) {
         ex(url: EndPoints.getUserInfo, completionHandler: completionHandler, errorHandler: errorHandler)
    }
    
}
