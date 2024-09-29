

import Foundation

protocol CoreDataRepository {
    func saveMovies(_ movies: [Movie])
    func fetchMovies() -> [Movie]?
}
