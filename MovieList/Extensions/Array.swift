//
//  Array.swift
//  MovieList
//
//  Created by Berkehan on 19.02.2021.
//

import Foundation
extension Array where Element == Movie {
    
    //Saves array to local storage. Keyyed with userId+some constan.
    func persist() {
        let targetItemKey: localStorageKeys = .favoriteMovie //Key for the item we are dealing.
  
        do {
            let encodedIssues = try JSONEncoder().encode(self)
            UserDefaults.standard.set(encodedIssues, forKey: targetItemKey.rawValue)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    //Fetches array from local storage.
    func fetchFavourites() -> [Movie]? {
        let targetItemKey: localStorageKeys = .favoriteMovie
        do {
            guard let persistedIssues = UserDefaults.standard.value(forKey: targetItemKey.rawValue) as? Data else { return nil }
            let decodedIssues = try JSONDecoder().decode([Movie].self, from: persistedIssues)
            return decodedIssues
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    func changePostersToFullUrl() -> [Movie]  {
        var movieArrayHolder = [Movie]()
        for var movie in self {
            movie.posterPath = GetPoster.getPosterUrl(width: 300, posterString: movie.posterPath!)
            movieArrayHolder.append(movie)
        }
        return movieArrayHolder
        
    }


}
