//
//  Constants.swift
//  banquemisr.challenge05.Movies
//
//  Created by Shady Adel on 27/09/2024.
//

import Foundation

enum movieListType {
    case nowPlaying
    case popular
    case upcoming
    
    var description: String {
        switch self {
        case .nowPlaying:
            return "now_playing"
        case .popular:
            return "popular"
        case .upcoming:
            return "upcoming"
        }
    }
}

struct Constants {
    
    static let baseUrl =  "https://api.themoviedb.org/3/movie/"
    
    static let genreUrl = "https://api.themoviedb.org/3/genre/movie/list"
    
    static let apiKey = "?api_key=b855ec2e0f4c2278145a1be962d0d973"
    
    static let imgUrl = "https://image.tmdb.org/t/p/w200"
    
}
