//
//  NetworkConstants.swift
//  MovieList
//
//  Created by Berkehan on 17.02.2021.
//

import Foundation
import UIKit
public struct NetworkConstants {
    
    static let baseUrl = "https://api.themoviedb.org/3"
    static let createImageUrl = "https://image.tmdb.org/t/p"
    
    struct APIParameterKey {
        static let ApiKey = "fd2b04342048fa2d5f728561866ad52a"
    }
    
   
}

enum ContentType: String{
    case json = "application/json"
}

enum  HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}
