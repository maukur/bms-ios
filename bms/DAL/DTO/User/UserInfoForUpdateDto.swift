//
//  UserInfoForUpdateDto.swift
//  bms
//
//  Created by Sergey on 17.09.2020.
//  Copyright © 2020 Artem Tischenko. All rights reserved.
//

import Foundation

struct UserInfoForUpdateDto: Codable {
    let fullName: String
    let birthDate: Date
    let phone: String
}
