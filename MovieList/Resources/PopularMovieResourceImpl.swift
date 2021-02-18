//
//  PopularMovieResourceImp.swift
//  MovieList
//
//  Created by Berkehan on 17.02.2021.
//

import Foundation
protocol PopularMovieResource {
    func getPopularMovies(page:Int,completion: @escaping (Swift.Result<MovieModal?,Error>) -> Void)

}

struct PopularMovieResourceImpl: PopularMovieResource {
    let network = MovieNetwork()

    func getPopularMovies(page:Int,completion: @escaping (Result<MovieModal?, Error>) -> Void) {
        let target = MultiTarget(TheMovieTarget.getPopularMovie(page: page))
        
        network.performObjectRequest(target: target) { (response) in
            completion(response)
        }
        
    }
    

}
