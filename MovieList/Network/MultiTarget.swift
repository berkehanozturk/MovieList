//
//  MultiTarget.swift
//  MovieList
//
//  Created by Berkehan on 17.02.2021.
//

import Foundation
enum NetworkResponse<T> {
  case success(T)
  case failure(NetworkError)
}
enum NetworkError {
    case unknown
    case noJSONData
  }
public class MultiTarget {
    var requestTimeout_second = 15.0
    var target : ApiTarget?

    init(_ target : ApiTarget) {
        self.target = target
    }
    
    var defaultSession = URLSession(configuration: .default)

    func objectRequest<T: Decodable>(completion : @escaping(NetworkResponse<T>) -> ()) {

        do{
            let request =  try self.asURLRequest()
            let task = defaultSession.dataTask(with: request) { (data, response, err) in
                let httpResponse = response as? HTTPURLResponse
                self.handleDataResponse(data: data, response: httpResponse, error: err, completion: completion) 
                
            }
            task.resume()

        }
        catch let conwertUrlError {
             print(conwertUrlError)
        }
        
    }
    
}
extension MultiTarget  {
    private func handleDataResponse<T: Decodable>(data: Data?, response: HTTPURLResponse?, error: Error?, completion: (NetworkResponse<T>) -> ()) {
        guard error == nil else { return completion(.failure(.unknown)) }
        guard let response = response else { return completion(.failure(.noJSONData)) }

        switch response.statusCode {
        case 200...299:
            guard let data = data, let model = try? JSONDecoder().decode(T.self, from: data) else { return completion(.failure(.unknown)) }
            completion(.success(model))
        default:
            completion(.failure(.unknown))
        }
    }

    public func asURLRequest() throws -> URLRequest {
        let url =  URL(string: target!.baseUrl)
        var urlRequest = URLRequest.init(url: url!.appendingPathComponent(target!.path))
        urlRequest.httpMethod = target?.method.rawValue
        urlRequest.timeoutInterval = requestTimeout_second
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        if let parameters = target?.parameters {
            if let method = target?.method {
                switch method {
                case .get:
                    let parametredString = urlRequest.url?.url(with: target!.baseUrl, path: target!.path, parameters: parameters as? [String : Any] ?? ["":""])
                    let parametredUrl = URL(string: parametredString!)
                    urlRequest = URLRequest(url: ((parametredUrl ?? urlRequest.url) ?? url)!)
                    
                case .post:
                
                    do  {
                        urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
                    }
                    catch let parseError {
                        print(parseError)
                    }
                    
                  
                    
                }
            }
        }
        
        return urlRequest

        }
}
    



