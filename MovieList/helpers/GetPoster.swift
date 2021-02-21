//
//  getPoster.swift
//  MovieList
//
//  Created by Berkehan on 17.02.2021.
//

import Foundation
class GetPoster {
    /// this function gets posterPath and return full url
    static func getPosterUrl(width: Int,posterString: URL)-> URL? {
        
        let urlString = "\(NetworkConstants.createImageUrl)/w\(width)\(posterString)"
        guard let url = URL(string: urlString) else { return nil  }
        
        return url
        
    }
}

