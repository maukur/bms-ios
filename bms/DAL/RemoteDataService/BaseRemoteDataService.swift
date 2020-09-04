
import Foundation
import Alamofire

class BaseRemoteDataService  {
    
    let baseUrl: String
    let decoder: JSONDecoder
    let getToken: ()->(String?)
    let unautorized: ()->()
    
    init(baseUrl:String,  unautorized: @escaping ()->(),getToken: @escaping ()->String?) {
        self.baseUrl = baseUrl
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(formatter)
        self.decoder = decoder
        self.getToken = getToken
        self.unautorized = unautorized
    }
    
    func ex<T:Codable>(url:String, method:HTTPMethod = .get, parameters:Parameters = [:], encoding:  ParameterEncoding = URLEncoding.default, completionHandler: @escaping (T) -> (), errorHandler: ((String) -> ())? = nil){
        
        var headers: HTTPHeaders = []
        let token = getToken()
        if(token != nil){
            let authHeader: HTTPHeader = HTTPHeader.authorization(bearerToken: token!)
            headers.add(authHeader)
        }
        let fullUrl = getFulUrl(url)
        AF.request(fullUrl, method: method, parameters: parameters, encoding: encoding, headers: headers).response {
            response in
            do {
                if let error = response.error {
                    errorHandler?(error.localizedDescription)
                    guard let statusCode = error.responseCode else { return }
                    if(statusCode == 401) {
                        self.unautorized()
                    }
                }
                
                #if DEBUG
                if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                    print("Data: \(utf8Text)")
                }
                #endif
                
                let jsonData: T = try self.decoder.decode(T.self, from: response.data!)
                completionHandler(jsonData)
            } catch let DecodingError.dataCorrupted(context) {
                errorHandler?("dataCorrupted")
                print(context)
            } catch let DecodingError.keyNotFound(key, context) {
                errorHandler?("Key '\(key)' not found:" + context.debugDescription)
                
            } catch let DecodingError.valueNotFound(value, context) {
                errorHandler?("Key '\(value)' not found:" + context.debugDescription)
            } catch let DecodingError.typeMismatch(type, context)  {
                errorHandler?("Key '\(type)' not found:" + context.debugDescription)
                
            } catch {
                errorHandler?(error.localizedDescription)
                print("error: ", error)
            }
        }
    }
    
    
    private func getFulUrl(_ url:String)-> URL{
        URL(string: baseUrl + url)!
    }
    
    
}

