//
//  MovieListTests.swift
//  MovieListTests
//
//  Created by Berkehan on 17.02.2021.
//

import XCTest
@testable import MovieList

class MovieListTests: XCTestCase {

    func testGettingUrl() {
        let testMovie = Movie(movieTitle: "Lotr", movieImageUrl: URL(string: "someUrl"), movieVoteCount: 200, movieOverView: "frodo is a good  person to take the risk", movieIsFavourite: false, MovieId: 1)
        let result = testMovie.isFavouriteMovie()
         XCTAssertFalse(result)
        let urlResult = GetPoster.getPosterUrl(width: 200, posterString: testMovie.posterPath!)
        XCTAssertEqual(urlResult, URL(string: "https://image.tmdb.org/t/p/w200someUrl"))
    }
    func test_API_BaseURLString_IsCorrect() {
        let baseURLString = NetworkConstants.baseUrl
           let expectedBaseURLString = "https://api.themoviedb.org/3"
           XCTAssertEqual(baseURLString, expectedBaseURLString, "Base URL does not match expected base URL. Expected base URLs to match.")
    }
    
  

}
