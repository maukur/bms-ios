//
//  UserInfoObject.swift
//  bms
//
//  Created by Sergey on 14.08.2020.
//  Copyright © 2020 Artem Tischenko. All rights reserved.
//
 

import Foundation

struct UserInfoObject: Codable {
    var fullName: String
    var birthDate: Date
    var employedDate: Date
    var email: String
    var phone: String
}
