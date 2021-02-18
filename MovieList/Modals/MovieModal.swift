//
//  MovieModal.swift
//  MovieList
//
//  Created by Berkehan on 17.02.2021.
//

import Foundation

struct MovieModal: Codable {
    var page: Int?
    var results: [Results]?
    var total_pages: Int?
    var total_results: Int?

}
struct Results: Codable {
    var id: Int?
    var voteCount: Int?
    var posterPath: String?
    var title: String?
    var overView: String?
    enum CodingKeys: String, CodingKey  {
        case voteCount  = "vote_count"
        case id = "id"
        case posterPath = "poster_path"
        case title
        case overView = "overview"
    }
    
}
