//
// Created by Sergey on 05.09.2020.
// Copyright (c) 2020 Artem Tischenko. All rights reserved.
//

import Foundation

enum StatusEnum: Int, Codable {
        case none = -1
        case created = 0
        case approved = 1
        case declined = 2
}
