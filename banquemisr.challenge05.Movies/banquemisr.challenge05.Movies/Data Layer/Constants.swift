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
    
    static let apiKey = "?api_key=b855ec2e0f4c2278145a1be962d0d973"
    
    static let imgUrl = "https://image.tmdb.org/t/p/w200"
    
    static let genres: [Int: String] = [
        28: "Action",
        12: "Adventure",
        16: "Animation",
        35: "Comedy",
        80: "Crime",
        99: "Documentary",
        18: "Drama",
        10751: "Family",
        14: "Fantasy",
        36: "History",
        27: "Horror",
        10402: "Music",
        9648: "Mystery",
        10749: "Romance",
        878: "Science Fiction",
        10770: "TV Movie",
        53: "Thriller",
        10752: "War",
        37: "Western"
    ]
    
}
