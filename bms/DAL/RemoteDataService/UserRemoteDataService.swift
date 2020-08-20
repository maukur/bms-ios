//
//  AccountRemoteDataService.swift
//  bms
//
//  Created by Sergey on 14.08.2020.
//  Copyright © 2020 Artem Tischenko. All rights reserved.
//

import Foundation

class UserRemoteDataService: BaseRemoteDataService, UserProtocol {
    func getUserInfo(completionHandler: @escaping (UserInfoObject) -> (), errorHandler: ((String) -> ())?) {
         ex(url: EndPoints.getUserInfo, completionHandler: completionHandler, errorHandler: errorHandler)
    }
    func login(login: String, password: String, onCompleted: (RequestResult<LoginResponseObject>) -> Void) {
        
    }
}
