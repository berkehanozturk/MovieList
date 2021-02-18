//
//  getPoster.swift
//  MovieList
//
//  Created by Berkehan on 17.02.2021.
//

import Foundation
class SetPoster {
    static func setPoster(width: Int,posterString: String)-> URL? {
        
        let urlString = "\(NetworkConstants.createImageUrl)w\(width)\(posterString)"
        print(urlString)
        guard let url = URL(string: urlString) else { return nil  }
        
        return url
        
    }
}

