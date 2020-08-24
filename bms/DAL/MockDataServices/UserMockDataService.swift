//
//  UserMockDataService.swift
//  OrderKing
//
//  Created by Artem Tischenko on 14.05.2020.
//  Copyright © 2020 Artem Tischenko. All rights reserved.
//

import Foundation

class UserMockDataService: BaseMockDataService, UserProtocol {
    func getUserInfo(completionHandler: @escaping (UserInfoDto) -> (), errorHandler: ((String) -> ())?) {
            
    }
   
    
    func login(login: String, password: String, onCompleted: (RequestResult<LoginResponseObject>) -> Void) {
        let result: RequestResult<LoginDto> = MakeRequestFromJson(fileName: "loginJson")
        onCompleted(RequestResult<LoginResponseObject>(data: result.data?.convert, status: result.status, message: result.message))
    }
}
