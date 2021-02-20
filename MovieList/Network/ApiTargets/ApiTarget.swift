//
//  ApiTarget.swift
//  MovieList
//
//  Created by Berkehan on 17.02.2021.
//

import UIKit
enum RequestHTTPMethod: String {
    case get = "GET"
    case post = "POST"
}
 protocol ApiTarget {
    var baseUrl: String{get}
    var path: String{get}
    var parameters: Codable? {get}
    var method: RequestHTTPMethod{get}
}
