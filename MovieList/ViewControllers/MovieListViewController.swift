//
//  MovieListViewController.swift
//  MovieList
//
//  Created by Berkehan on 17.02.2021.
//

import UIKit

class MovieListViewController: UIViewController {
    private let MovieResource: PopularMovieResource = PopularMovieResourceImpl()
    private let posterResource : CreatePosterResource = CreatePosterResourceImpl()
    var movieResultArray = [Results]()
    override func viewDidLoad() {
        super.viewDidLoad()
      
        fetchPopularMovies()
        
        
    }
    private func fetchPopularMovies() {
        
        MovieResource.getPopularMovies { (dataResponse) in
            switch dataResponse {
            case .success(let movieResults):
                if let unWrappedMovieResults = movieResults {
                    if unWrappedMovieResults.results != nil {
                        self.movieResultArray = unWrappedMovieResults.results!
                    }
                }
            case .failure(_):
                break
                
            }
        }
        
    }
    
//    private func getMoviesPoster() {
//        for i in movieResultArray {
//            if let posterString = i.posterPath{
//                let url = SetPoster.setPoster(width: 200, posterString: posterString)
//
//            }
//        }
//
//    }

}

