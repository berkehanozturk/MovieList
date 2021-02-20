//
//  TheMovieTarget.swift
//  MovieList
//
//  Created by Berkehan on 17.02.2021.
//

import Foundation

enum TheMovieTarget: ApiTarget {
    case getPopularMovie(page:Int)
    
    var baseUrl: String {
        switch self {
        case .getPopularMovie:
            return NetworkConstants.baseUrl
   
        }
    }
    var path: String {
        switch self {
        case .getPopularMovie:
            return "/movie/popular"
   
        }
    }
    var parameters: Codable? {
        switch self {
        case .getPopularMovie(let page):
            return ["api_key":"\(NetworkConstants.APIParameterKey.ApiKey)","page":"\(page)"]
    
        }
    }
   
    var method: RequestHTTPMethod{
        switch self {
        case .getPopularMovie:
            return RequestHTTPMethod.get
        }
    }
    
    
    
}
