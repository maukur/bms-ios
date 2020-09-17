//
//  EventObject.swift
//  bms
//
//  Created by Artem Tischenko on 13.08.2020.
//  Copyright © 2020 Artem Tischenko. All rights reserved.
//

import Foundation

struct EventObject:Codable {
	var id: String
	var reason: String
	var type: String
	var status: StatusEnum
}
