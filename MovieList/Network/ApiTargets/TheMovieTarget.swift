//
//  TheMovieTarget.swift
//  MovieList
//
//  Created by Berkehan on 17.02.2021.
//

import Foundation

enum TheMovieTarget: ApiTarget {
    case getPopularMovie
    
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
        case .getPopularMovie:
            return ["api_key":"\(NetworkConstants.APIParameterKey.ApiKey)"]
    
        }
    }
    var displayLoader: Bool {
        switch self {
        case .getPopularMovie:
            return true
     
        }
    }
    var method: RequestHTTPMethod{
        switch self {
        case .getPopularMovie:
            return RequestHTTPMethod.get
        }
    }
    
    
    
}
