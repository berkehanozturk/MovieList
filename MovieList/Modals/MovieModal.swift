//
//  MovieModal.swift
//  MovieList
//
//  Created by Berkehan on 17.02.2021.
//

import Foundation

struct MovieModal: Codable {
    var page: Int?
    var results: [Movie]?
    var total_pages: Int?
    var total_results: Int?
  
}

struct Movie: Codable,Hashable {
    var title: String?
    var posterPath: URL?
    var voteCount: Int?
    var overView: String?
    var isFavourite: Bool?
    var id: Int?
    var vote_average: Float?
  
    enum CodingKeys: String, CodingKey  {
        case voteCount  = "vote_count"
        case id = "id"
        case posterPath = "poster_path"
        case title
        case overView = "overview"
        case vote_average
    }
   
    init(movieTitle: String?, movieImageUrl: URL?, movieVoteCount: Int?, movieOverView: String?, movieIsFavourite: Bool? = false,MovieId : Int?,movieVoteAvarage: Float?) {
        title = movieTitle
        posterPath = movieImageUrl
        voteCount = movieVoteCount
        overView = movieOverView
        isFavourite = movieIsFavourite
        id = MovieId
        vote_average = movieVoteAvarage
        
    }
  
    // check for favourite movies   if is favourite return  true
    func isFavouriteMovie() -> Bool {
        var returnValue = false
        for movie in GlobalVariables.favouriteMovies{
            if movie.id == self.id {
                returnValue = true
            }
        }
        return returnValue
    }
    ///This function is for adding  favorites in issue
    func addIssueToFavourites() {
        GlobalVariables.favouriteMovies.append(self)
        GlobalVariables.favouriteMovies.persist()
    }
    
    ///This function is for removing favorites in issue
    func removeFromFavourites() {
        var movieIndex = 0
        for currenMovie in GlobalVariables.favouriteMovies {
            if currenMovie.id == self.id {
                GlobalVariables.favouriteMovies.remove(at: movieIndex)
                GlobalVariables.favouriteMovies.persist()
                return
            }
            movieIndex+=1
        }
    }
    

}
