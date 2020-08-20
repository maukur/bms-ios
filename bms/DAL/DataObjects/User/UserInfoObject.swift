//
//  UserInfoObject.swift
//  bms
//
//  Created by Sergey on 14.08.2020.
//  Copyright © 2020 Artem Tischenko. All rights reserved.
//

import Foundation

struct UserInfoObject: Codable {
    let fullName: String
    let birthDate: String
    let employedDate: String
    let email: String
    let phone: String
}
