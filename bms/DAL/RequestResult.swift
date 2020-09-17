//
//  RequestResult.swift
//  OrderKing
//
//  Created by Artem Tischenko on 14.05.2020.
//  Copyright © 2020 Artem Tischenko. All rights reserved.
//

import Foundation

struct RequestResult<T> {
    var data: T?
    var status: String = "ok"
    var message: String?
    
    func isValid() -> Bool {
        data != nil && status == "ok"
    }
    
    static func getError() -> RequestResult<T> {
        RequestResult<T>(data: nil, status: "error", message: "errorMessage")
    }
}
