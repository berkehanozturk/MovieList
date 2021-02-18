//
//  MultiTarget.swift
//  MovieList
//
//  Created by Berkehan on 17.02.2021.
//

import Foundation

public class MultiTarget {
    var requestTimeout_second = 15.0
    var target : ApiTarget?

    init(_ target : ApiTarget) {
        self.target = target
    }
    
    var defaultSession = URLSession(configuration: .default)

    func objectRequest<T: Decodable>(completion : @escaping(Swift.Result<T,Error>) -> () ){

        do {
            let request =  try self.asURLRequest()
            let task = defaultSession.dataTask(with: request) { (data, response, err) in
                guard let data = data else { return }
                let result = Result {  try JSONDecoder().decode(T.self, from: data)  }
                completion(result)
            }
            task.resume()

        }
        catch let conwertUrlError {
             print(conwertUrlError)
        }
        
    }
    
}

extension MultiTarget  {
    
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
    



