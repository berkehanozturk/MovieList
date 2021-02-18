//
//  MovieNetwork.swift
//  MovieList
//
//  Created by Berkehan on 17.02.2021.
//

import Foundation

class MovieNetwork {

    func performObjectRequest<T:Decodable>(target: MultiTarget, completion: @escaping(Swift.Result<T,Error>) -> Void) {
        target.objectRequest(completion: completion)
        
    }

    
}
