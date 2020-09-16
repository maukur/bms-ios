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

    let tabBarSettings: [String: (String, String)] = [
        "Calendar": ("CALENDAR", "calendar"),
        "Expenses": ("EXPENSES", "dollarsign.circle"),
        "Profile": ("PROFILE", "person.circle")]
}
