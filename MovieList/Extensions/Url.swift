//
//  Url.swift
//  MovieList
//
//  Created by Berkehan on 17.02.2021.
//

import Foundation
extension URL {

    func url(with baseUrl : String, path : String, parameters : [String : Any]) -> String? {
        var parametersString = baseUrl + path + "?"
        for (key, value) in parameters {
            if let encodedKey = key.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
                let encodedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
                parametersString.append(encodedKey + "=" + "\(encodedValue)" + "&")
            } else {
                print("Could not urlencode parameters")
                return nil
            }
        }
        parametersString.removeLast()
        return parametersString
    }
}
