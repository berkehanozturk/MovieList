//
//  PopularMovieResourceImp.swift
//  MovieList
//
//  Created by Berkehan on 17.02.2021.
//

import Foundation
protocol PopularMovieResource {
    func getPopularMovies(page: Int,completion: @escaping (NetworkResponse<MovieModal>)-> Void)

}

struct PopularMovieResourceImpl: PopularMovieResource {
    func getPopularMovies(page: Int, completion: @escaping (NetworkResponse<MovieModal>) -> Void) {
        let target = MultiTarget(TheMovieTarget.getPopularMovie(page: page))
        
        network.performObjectRequest(target: target) { (response) in
            completion(response)
        }
    }
    
    let network = MovieNetwork()

   
    

}
