//
//  Constants.swift
//  MovieDB
//
//  Created by Shreyansh Raj  Keshri on 13/12/23.
//

import Foundation


struct Constants {
    static let apiKey = "38a73d59546aa378980a88b645f487fc"
    //MARK: - Home
    struct Home {
        static let navTitle = "Movie DB"
        static let movieDetailsURL = "https://api.themoviedb.org/3/movie/now_playing"
        
        struct Table {
            static let movieDetailsCell =  "MovieDetailsTableViewCell"
        }
    }
}
