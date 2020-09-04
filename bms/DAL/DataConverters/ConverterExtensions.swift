//
//  LoginResponseConverter.swift
//  OrderKing
//
//  Created by Artem Tischenko on 14.05.2020.
//  Copyright © 2020 Artem Tischenko. All rights reserved.
//

import Foundation

extension LoginDto {
//    var convert: LoginResponseObject {
//        LoginResponseObject(token: self.token!, email: self.email ?? "", phone: self.phone ?? "")
//    }
}

extension UserInfoDto {
    var convert: UserInfoObject {
        UserInfoObject(fullName: self.fullName, birthDate: self.birthDate.toDate(), employedDate: self.employedDate.toDate(), email: self.email, phone: self.phone)
    }
}


