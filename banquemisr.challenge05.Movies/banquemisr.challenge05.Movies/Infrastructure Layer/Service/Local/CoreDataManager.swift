import CoreData
import UIKit

class CoreDataManager: CoreDataRepository {
    func saveMovies(_ movies: [Movie]) {
        _ = 5
    }
    
    func fetchMovies() -> [Movie] {
        return []
    }
    
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "banquemisr_challenge05_Movies")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
//    func saveMovies(_ movies: [Movie]) {
//        for movie in movies {
//            let movieEntity = MovieEntity(context: context)
//            movieEntity.genreIds = movie.genre_ids?.map { String($0) }
//            movieEntity.popularity = movie.popularity ?? 0.0
//            movieEntity.posterPath = movie.poster_path
//            movieEntity.overview = movie.overview
//            movieEntity.title = movie.title
//            movieEntity.releaseDate = movie.release_date
//        }
//        
//        do {
//            try context.save()
//        } catch {
//            print("Failed to save movies: \(error)")
//        }
//    }
    
//    func fetchMovies() -> [Movie] {
//        var movies: [Movie] = []
//        
//        let fetchRequest: NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
//        
//        do {
//            let movieEntities = try context.fetch(fetchRequest)
//            movies = movieEntities.compactMap { entity in
//                return Movie(
//                    genre_ids: entity.genreIds?.compactMap { Int($0) },
//                    popularity: entity.popularity,
//                    poster_path: entity.posterPath,
//                    overview: entity.overview,
//                    title: entity.title,
//                    release_date: entity.releaseDate
//                )
//            }
//        } catch {
//            print("Failed to fetch movies: \(error)")
//        }
//        
//        return movies
//    }
}
