//
//  BaseRemoteDataService.swift
//  OrderKing
//
//  Created by Artem Tischenko on 21.05.2020.
//  Copyright © 2020 Artem Tischenko. All rights reserved.
//

import Foundation

class BaseRemoteDataService  {
    
    let baseUrl: String
    let session: URLSession
    let json = JSONDecoder()
    
    init(baseUrl:String, session:URLSession) {
        self.baseUrl = baseUrl
        self.session = session
    }
    
    
    func POST<ModelType: Encodable>(url: String, token: String? = nil, model: ModelType) -> URLRequest {
        
        var request = getUrlRequest(getFulUrl(url), token: token, method: "POST");
        
        let encoder = JSONEncoder()
        let encoded = try! encoder.encode(model)
        request.httpBody = encoded
        
        return request
    }
    
    
    
    func GET(url: String, token: String? = nil) -> URLRequest {
        let request = getUrlRequest(getFulUrl(url), token: token, method: "GET");
        return request
    }
    
    
    func GET(url: String, token: String? = nil, parameters: [String: String]) -> URLRequest {
        var components = URLComponents(url: getFulUrl(url), resolvingAgainstBaseURL: false)!
        
        components.queryItems = parameters.enumerated().map {
            URLQueryItem(name: $1.key, value: $1.value)
        }
        
        guard let percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B") else {
            return URLRequest(url: components.url!)
        }
        
        components.percentEncodedQuery = percentEncodedQuery
        
        let request = getUrlRequest(components.url!, token: token, method: "GET");
        return request
        
    }
    
    
    func execute<T:Codable>(_ request: URLRequest) -> RequestResult<T>{
        let semaphore = DispatchSemaphore(value: 0)

        var reuestResult:RequestResult<T>? = nil

        session.dataTask(with: request) {
            (data, response , error) in
           
            
            do {
                let decoder = JSONDecoder()
                let jsonData: T = try decoder.decode(T.self, from: data!)
                reuestResult = RequestResult(data: jsonData, status: "ok")
                semaphore.signal()
                
            }
            catch let DecodingError.typeMismatch(type, context)  {
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
            }
            catch {
                print(error.localizedDescription)
            
             semaphore.signal()
            }
        }.resume()
        semaphore.wait()
        return reuestResult!
    }
    
    func decode<ResultType: Decodable>(_ response: Data) throws -> ResultType {
        try json.decode(ResultType.self, from: response)
    }
    
    private func getFulUrl(_ url:String)-> URL{
        URL(string: baseUrl + url)!
    }
    
    private func getUrlRequest(_ url:URL, token: String? = nil, method: String) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        
        if let _token = token {
            request.addValue("Bearer \(_token)", forHTTPHeaderField: "Authorization")
        }
        return request
    }
    
}

