//
//  SettingsService.swift
//  OrderKing
//
//  Created by Artem Tischenko on 14.05.2020.
//  Copyright © 2020 Artem Tischenko. All rights reserved.
//

import Foundation

class SettingsService:BaseSettingsService {
 
    private override init() { }
    static var instance = SettingsService()

    
    var token: String {
        set { SettingsService.set(newValue, for: #function) }
        get {
            SettingsService.get(#function) ?? ""
        }
    }
}

class BaseSettingsService {
    
       fileprivate static var domainName: String {
           Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as! String
       }
       
       fileprivate static func set<T>(_ newValue: T, for key: String) {
           UserDefaults.standard.setValue(newValue, forKey: key)
           UserDefaults.standard.synchronize()
       }
       
       fileprivate static func get<T>(_ key: String) -> T? {
           UserDefaults.standard.value(forKey: key) as? T
       }
       
       func reset(for key: String) {
           UserDefaults.standard.setValue(nil, forKey: key)
           UserDefaults.standard.synchronize()
       }
}
