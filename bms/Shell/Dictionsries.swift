//
//  Dictionsries.swift
//  bms
//
//  Created by Artem Tischenko on 13.08.2020.
//  Copyright © 2020 Artem Tischenko. All rights reserved.
//

import Foundation

 class Dictionaries {
    
    static let instance = Dictionaries()

    let tabBarSettings :Dictionary<String, (String, String)> = [
        "Calendar":("Calendar", "calendar"),
        "Expenses":("Expenses", "dollarsign.circle"),
        "Profile":("Profile", "person.circle"),

    ]
}
