//
//  UserInfoDto.swift
//  bms
//
//  Created by Sergey on 14.08.2020.
//  Copyright © 2020 Artem Tischenko. All rights reserved.
//

import Foundation

struct UserInfoDto: Codable {
    let fullName: String
    let birthDate: String
    let employedDate: String
    let phone: String
    let email: String
}
