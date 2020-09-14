//
//  MockDataService.swift
//  OrderKing
//
//  Created by Artem Tischenko on 14.05.2020.
//  Copyright © 2020 Artem Tischenko. All rights reserved.
//

import Foundation

class BaseMockDataService {
    let decoder: JSONDecoder
    let encoder: JSONEncoder
    init() {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd"
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(formatter)
        self.decoder = decoder
        
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .formatted(formatter)
        self.encoder = encoder
    }
    private func loadJson(fileName: String) -> Data {
        
        let url = Bundle.main.path(forResource: fileName, ofType: "json")!
        
        do {
            return try String(contentsOfFile: url).data(using: .utf8)!
        }
        catch {
            
        }
        
        return Data()
    }
    
    func MakeRequestFromJson<T>(fileName: String, completionHandler: @escaping (T) -> (), errorHandler: ((String) -> ())? = nil) where T: Decodable {
        
        let data = loadJson(fileName: fileName)
        
        do {
            
            let jsonData: T = try decoder.decode(T.self, from: data)
            completionHandler(jsonData)
            
        }
        catch let DecodingError.typeMismatch(type, context)  {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
            errorHandler?("Error")
        }
        catch {
            errorHandler?("Error")
        }
    }
}
