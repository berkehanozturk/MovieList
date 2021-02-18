//
//  Movie.swift
//  MovieList
//
//  Created by Berkehan on 18.02.2021.
//

import Foundation

struct Movie {
    var title: String?
    var imageUrl: URL?
    var voteCount: Int?
    var overView: String?
    var isFavourite: Bool?
    init(movieTitle: String?, movieImageUrl: URL?, movieVoteCount: Int?, movieOverView: String?, movieIsFavourite: Bool? = false) {
        title = movieTitle
        imageUrl = movieImageUrl
        voteCount = movieVoteCount
        overView = movieOverView
        isFavourite = movieIsFavourite
    }
}
