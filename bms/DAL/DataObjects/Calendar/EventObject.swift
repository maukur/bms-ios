//
//  EventObject.swift
//  bms
//
//  Created by Artem Tischenko on 13.08.2020.
//  Copyright © 2020 Artem Tischenko. All rights reserved.
//

import Foundation
//{
//	"id": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
//	"status": 0,
//	"type": "string",
//	"reason": "string"
//}

struct EventObject:Codable {
	var id: String
	var reason: String
	var type: String
	var status: StatusEnum
}
