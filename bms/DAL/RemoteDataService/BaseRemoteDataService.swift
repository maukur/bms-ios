import Foundation
import Alamofire

class BaseRemoteDataService {

    let baseUrl: String
    let decoder: JSONDecoder
    let getToken: () -> (String?)
    let unauthorized: () -> ()

    init(baseUrl: String, unauthorized: @escaping () -> (), getToken: @escaping () -> String?) {
        self.baseUrl = baseUrl
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(formatter)
        self.decoder = decoder
        self.getToken = getToken
        self.unauthorized = unauthorized
    }

    func ex<T: Codable>(url: String, method: HTTPMethod = .get, parameters: Parameters = [:], encoding: ParameterEncoding = URLEncoding.default, completionHandler: @escaping (T) -> (), errorHandler: ((String) -> ())? = nil) {
        var headers: HTTPHeaders = []
        let token = getToken()
        if (token != nil) {
            let authHeader: HTTPHeader = HTTPHeader.authorization(bearerToken: token!)
            headers.add(authHeader)
        }
        let fullUrl = getFulUrl(url)
        AF.request(fullUrl, method: method, parameters: parameters, encoding: encoding, headers: headers)
                .validate(statusCode: 200..<300)
                .response {
            [weak self] response in
            guard let self = self else { return }

            switch response.result {
            case .success(_):
                print("finish")
                self.onResponse(response: response, completionHandler: completionHandler, errorHandler: errorHandler)
                break
            case .failure(let error):
                if (response.response?.statusCode == 401) {
                    self.unauthorized()
                } else {
                    errorHandler?(error.errorDescription!)
                }
                break
            }
        }
    }

    func ex(url: String, body: Encodable, method: HTTPMethod = .get, completionHandler: @escaping () -> (), errorHandler: ((String) -> ())? = nil) {
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
        request.httpBody = body.toJSONData()
        AF.request(request)
                .validate(statusCode: 200..<300)
                .response {
            [weak self] response in
            guard let self = self else { return }

            switch response.result {
            case .success(_):
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

    func ex(url: String, method: HTTPMethod = .get, parameters: Parameters = [:], encoding: ParameterEncoding = URLEncoding.default, completionHandler: @escaping () -> (), errorHandler: ((String) -> ())? = nil) {

        var headers: HTTPHeaders = []
        let token = getToken()
        if (token != nil) {
            let authHeader: HTTPHeader = HTTPHeader.authorization(bearerToken: token!)
            headers.add(authHeader)
        }
        let fullUrl = getFulUrl(url)
        AF.request(fullUrl, method: method, parameters: parameters, encoding: encoding, headers: headers)
                .validate(statusCode: 200..<300)
                .response {
            [weak self] response in
            guard let self = self else { return }

            switch response.result {
            case .success(_):
                print("finish")
                self.onResponse(response: response, completionHandler: completionHandler, errorHandler: errorHandler)
            case .failure(let error):
                if (response.response?.statusCode == 401) {
                    self.unauthorized()
                } else {
                    errorHandler?(error.errorDescription!)
                }
            }
        }
    }

    private func onResponse<T: Codable>(response: AFDataResponse<Data?>, completionHandler: @escaping (T) -> (), errorHandler: ((String) -> ())? = nil) {
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

    private func onResponse(response: AFDataResponse<Data?>, completionHandler: @escaping () -> (), errorHandler: ((String) -> ())? = nil) {
        if let error = response.error {
            errorHandler?(error.localizedDescription)
            return
        }
        self.debugPrintResponse(response: response)
        completionHandler()
    }

    private func debugPrintResponse(response: AFDataResponse<Data?>) {
        #if DEBUG
        print("URL: \(response.response?.url)")
        if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
            print("Data: \(utf8Text)")
        }
        #endif
    }

    private func getFulUrl(_ url: String) -> URL {
        URL(string: baseUrl + url)!
    }
}


extension Encodable {
    func toJSONData() -> Data? {
        try? JSONEncoder().encode(self)
    }
}
