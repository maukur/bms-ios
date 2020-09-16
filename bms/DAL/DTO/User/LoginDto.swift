//
//  LoginResponseDto.swift
//  OrderKing
//
//  Created by Artem Tischenko on 14.05.2020.
//  Copyright © 2020 Artem Tischenko. All rights reserved.
//

import Foundation

class LoginDto: Decodable {
   var token: String?
   var email: String?
   var phone: String?
}
