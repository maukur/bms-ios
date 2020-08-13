//
//  MockDataService.swift
//  OrderKing
//
//  Created by Artem Tischenko on 14.05.2020.
//  Copyright © 2020 Artem Tischenko. All rights reserved.
//

import Foundation

class BaseMockDataService {
    
    private func loadJson(fileName: String) -> Data {
      
            let url = Bundle.main.url(forResource: fileName, withExtension: "json")
      
        do {
            return try Data(contentsOf: url!)
        }
        catch {
            
        }
        
        return Data()
     }
    
    func MakeRequestFromJson<T>(fileName: String) -> RequestResult<T>  where T: Decodable   {
        
            let data = loadJson(fileName: fileName)
        
        do {
            let decoder = JSONDecoder()
            let jsonData: T = try decoder.decode(T.self, from: data)
            return RequestResult(data: jsonData, status: "ok")
            
        }
        catch let DecodingError.typeMismatch(type, context)  {
           print("Type '\(type)' mismatch:", context.debugDescription)
           print("codingPath:", context.codingPath)
            return RequestResult<T>.getError()

        }
        catch {
            
            return RequestResult<T>.getError()
        }
    }
}
