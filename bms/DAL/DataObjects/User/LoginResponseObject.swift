//
//  LoginResponseDto.swift
//  OrderKing
//
//  Created by Artem Tischenko on 14.05.2020.
//  Copyright © 2020 Artem Tischenko. All rights reserved.
//

import Foundation

struct LoginResponseObject:Codable {
    var token : String
    var id: String
    var email : String
    var fullName : String
}
