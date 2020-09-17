import Foundation
import Alamofire

class BaseRemoteDataService {
    
    let baseUrl: String
    let decoder: JSONDecoder
    let encoder: JSONEncoder
    let getToken: () -> (String?)
    let unauthorized: () -> Void
    
    init(baseUrl: String, unauthorized: @escaping () -> Void, getToken: @escaping () -> String?) {
        self.baseUrl = baseUrl
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd"
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(formatter)
        self.decoder = decoder
        self.getToken = getToken
        self.unauthorized = unauthorized
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .formatted(formatter)
        self.encoder = encoder
    }
    
    func ex<T: Codable>(url: String,
                        method: HTTPMethod = .get,
                        parameters: Parameters = [:],
                        encoding: ParameterEncoding = URLEncoding.default,
                        completionHandler: @escaping (T) -> Void,
                        errorHandler: ((String) -> Void)? = nil) {
        var headers: HTTPHeaders = []
        let token = getToken()
        if (token != nil) {
            let authHeader: HTTPHeader = HTTPHeader.authorization(bearerToken: token!)
            headers.add(authHeader)
        }
        let fullUrl = getFulUrl(url)
        AF.request(fullUrl, method: method, parameters: parameters, encoding: encoding, headers: headers)
            .validate(statusCode: 200..<300)
            .response { [weak self] response in
                guard let self = self else { return }
                switch response.result {
                case .success:
                    print("finish")
                    self.onResponse(response: response,
                                    completionHandler: completionHandler,
                                    errorHandler: errorHandler)
                case .failure(let error):
                    if (response.response?.statusCode == 401) {
                        self.unauthorized()
                    } else {
                        errorHandler?(error.errorDescription!)
                    }
                }
        }
    }
    
    func ex<T: Encodable>(url: String,
                          body: T, method: HTTPMethod = .get,
                          completionHandler: @escaping () -> Void,
                          errorHandler: ((String) -> Void)? = nil) {
        var headers: HTTPHeaders = []
        let token = getToken()
        if (token != nil) {
            let authHeader: HTTPHeader = HTTPHeader.authorization(bearerToken: token!)
            headers.add(authHeader)
        }
        let fullUrl = getFulUrl(url)
        var request = URLRequest(url: fullUrl)
        request.httpMethod = method.rawValue
        request.headers = headers
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        var data: Data?
        do { data = try encoder.encode(body)} catch {
            print(error.localizedDescription)
        }
        request.httpBody = data!
        AF.request(request)
            .validate(statusCode: 200..<300)
            .response { [weak self] response in
                guard let self = self else { return }
                switch response.result {
                case .success:
                    print("finish")
                    completionHandler()
                case .failure(let error):
                    if (response.response?.statusCode == 401) {
                        self.unauthorized()
                    } else {
                        errorHandler?(error.errorDescription!)
                        print(error)
                    }
                }
        }
    }
    
    func ex(url: String,
            method: HTTPMethod = .get,
            parameters: Parameters = [:],
            encoding: ParameterEncoding = URLEncoding.default,
            completionHandler: @escaping () -> Void,
            errorHandler: ((String) -> Void)? = nil) {
        var headers: HTTPHeaders = []
        let token = getToken()
        if (token != nil) {
            let authHeader: HTTPHeader = HTTPHeader.authorization(bearerToken: token!)
            headers.add(authHeader)
        }
        let fullUrl = getFulUrl(url)
        AF.request(fullUrl, method: method, parameters: parameters, encoding: encoding, headers: headers)
            .validate(statusCode: 200..<300)
            .response { [weak self] response in
                guard let self = self else { return }
                switch response.result {
                case .success:
                    print("finish")
                    self.onResponse(response: response,
                                    completionHandler: completionHandler,
                                    errorHandler: errorHandler)
                case .failure(let error):
                    if (response.response?.statusCode == 401) {
                        self.unauthorized()
                    } else {
                        errorHandler?(error.errorDescription!)
                    }
                }
        }
    }
    
    private func onResponse<T: Codable>(response: AFDataResponse<Data?>,
                                        completionHandler: @escaping (T) -> Void,
                                        errorHandler: ((String) -> Void)? = nil) {
        do {
            if let error = response.error {
                errorHandler?(error.localizedDescription)
                return
            }
            self.debugPrintResponse(response: response)
            let jsonData: T = try self.decoder.decode(T.self, from: response.data!)
            completionHandler(jsonData)
        } catch let DecodingError.dataCorrupted(context) {
            errorHandler?("dataCorrupted")
            print("error: ", context)
        } catch let DecodingError.keyNotFound(key, context) {
            errorHandler?("Key '\(key)' not found:" + context.debugDescription)
            print("error: ", context)
        } catch let DecodingError.valueNotFound(value, context) {
            errorHandler?("Key '\(value)' not found:" + context.debugDescription)
            print("error: ", context)
        } catch let DecodingError.typeMismatch(type, context) {
            errorHandler?("Key '\(type)' not found:" + context.debugDescription)
            print("error: ", context)
        } catch {
            errorHandler?(error.localizedDescription)
            print("error: ", error)
        }
    }
    
    private func onResponse(response: AFDataResponse<Data?>,
                            completionHandler: @escaping () -> Void,
                            errorHandler: ((String) -> Void)? = nil) {
        if let error = response.error {
            errorHandler?(error.localizedDescription)
            return
        }
        self.debugPrintResponse(response: response)
        completionHandler()
    }
    
    private func debugPrintResponse(response: AFDataResponse<Data?>) {
        #if DEBUG
        print("URL: \(String(describing: response.response!.url))")
        if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
            print("Data: \(utf8Text)")
        }
        #endif
    }
    
    private func getFulUrl(_ url: String) -> URL {
        URL(string: baseUrl + url)!
    }
}
