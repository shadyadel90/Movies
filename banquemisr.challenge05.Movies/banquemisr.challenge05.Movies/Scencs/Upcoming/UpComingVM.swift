import UIKit

class UpcomingViewModel {
    private var movies: [Movie] = []
    private var imgs: [UIImage] = []
    var reloadTable: (() -> Void)?
    
    func fetchNowPlayingMovies() {
        NetworkService.fetchDataFromApi(movieListType: .upcoming) { [weak self] result in
            switch result {
            case .success(let movies):
                self?.movies = movies
                self?.fetchImages()
            case .failure(let error):
                print(error)
            }
        }
    }

    private func fetchImages() {
        let dispatchGroup = DispatchGroup()
        
        for item in movies {
            guard let posterPath = item.poster_path else { continue }
            dispatchGroup.enter()
            NetworkService.downloadImage(imageUrl: "\(Constants.imgUrl)\(posterPath)\(Constants.apiKey)") { [weak self] result in
                switch result {
                case .success(let image):
                    self?.imgs.append(image)
                case .failure(let error):
                    print(error)
                }
                dispatchGroup.leave()
            }
        }

        dispatchGroup.notify(queue: .main) { [weak self] in
            self?.reloadTable?()
        }
    }

    func numberOfMovies() -> Int {
        return movies.count
    }
    
    func movie(at index: Int) -> Movie {
        return movies[index]
    }
    
    func image(at index: Int) -> UIImage? {
        return index < imgs.count ? imgs[index] : UIImage(systemName: "photo")
    }
}
