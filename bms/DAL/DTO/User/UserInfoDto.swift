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
    let birthDate: Date
    let employedDate: Date
    let email: String
    let phone: String
}
