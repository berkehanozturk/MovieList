//
//  CreatePoster.swift
//  MovieList
//
//  Created by Berkehan on 17.02.2021.
//

import Foundation
protocol CreatePosterResource {
    func getPoster(width: Int,imageString:String, completion: @escaping (Swift.Result<Data, Error>) -> Void)

}

struct CreatePosterResourceImpl: CreatePosterResource {
    func getPoster(width: Int, imageString: String, completion: @escaping (Result<Data, Error>) -> Void) {
        
    }
    
    let network = MovieNetwork()

//    func getPoster(width: Int, imageString: String, completion: @escaping (Result<Data, Error>) -> Void) {
//        let target = MultiTarget(TheMovieTarget.getPoster(width: width, imageString: imageString))
//        target.basicRequest { (response) in
//            completion(response)
//        }
//    }
    

    
}
