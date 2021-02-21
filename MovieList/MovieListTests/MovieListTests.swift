//
//  MovieListTests.swift
//  MovieListTests
//
//  Created by Berkehan on 17.02.2021.
//

import XCTest
@testable import MovieList

class MovieListTests: XCTestCase {
    let testMovie = Movie(movieTitle: "Lotr", movieImageUrl: URL(string: "someUrl"), movieVoteCount: 200, movieOverView: "frodo is a good  person to take the risk", movieIsFavourite: false, MovieId: 1)
    func testGettingUrl() {
        let urlResult = GetPoster.getPosterUrl(width: 200, posterString: testMovie.posterPath!)
        XCTAssertEqual(urlResult, URL(string: "https://image.tmdb.org/t/p/w200someUrl"))
    }
    func testIsFavourite() {
        let result = testMovie.isFavouriteMovie()
        XCTAssertFalse(result)
    }
    func testAPIBaseURLStringIsCorrect(){
        let baseURLString = NetworkConstants.baseUrl
           let expectedBaseURLString = "https://api.themoviedb.org/3"
           XCTAssertEqual(baseURLString, expectedBaseURLString, "Base URL does not match expected base URL. Expected base URLs to match.")
    }
    func testParametredUrl(){
        
        let parameters = ["api_key":NetworkConstants.APIParameterKey.ApiKey]
        let baseURLString = NetworkConstants.baseUrl
        let url = URL(string: baseURLString)
        let parametredString = url?.url(with: baseURLString, path: "", parameters: parameters)
        let expectedURLString = "https://api.themoviedb.org/3?api_key=fd2b04342048fa2d5f728561866ad52a"
        XCTAssertEqual(parametredString, expectedURLString, "Base URL does not match expected base URL. Expected base URLs to match.")
    
    }
  

}
