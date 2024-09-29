import Foundation

struct result: Decodable {
    let results: [Movie]
}

struct Movie: Decodable {
    let genre_ids: [Int]?
    let popularity: Double?
    let poster_path: String?
    let overview: String?
    let title: String?
    let release_date: String?
}
