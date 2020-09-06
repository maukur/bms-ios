//
// Created by Sergey on 06.09.2020.
// Copyright (c) 2020 Artem Tischenko. All rights reserved.
//

import Foundation

struct UserInfoForUpdateObject: Codable {
	var fullName: String
	var birthDate: Date
	var phone: String
}