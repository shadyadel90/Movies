import UIKit

class PopularViewModel {
    private var movies: [Movie] = []
    private var images: [UIImage] = []
    var reloadTable: (() -> Void)?
    var showError: ((String) -> Void)?
    let network: NetworkRepository = NetworkService()

    func fetchNowPlayingMovies() {
        network.fetchDataFromApi(movieListType: .popular) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let movies):
                self.movies = movies
                self.fetchImages()
            case .failure:
                self.showError?(ErrorMessage.unableToComplete.rawValue)
            }
        }
    }

    private func fetchImages() {
        let dispatchGroup = DispatchGroup()

        for item in movies {
            guard let posterPath = item.poster_path else { continue }
            dispatchGroup.enter()
            network.downloadImage(imageUrl: "\(Constants.imgUrl)\(posterPath)\(Constants.apiKey)") { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let image):
                    self.images.append(image)
                case .failure(let error):
                    print(error)
                    self.showError?(ErrorMessage.invalidData.rawValue)
                }
                dispatchGroup.leave()
            }
        }

        dispatchGroup.notify(queue: .main) {
            self.reloadTable?()
        }
    }

    func numberOfMovies() -> Int {
        return movies.count
    }

    func didSelectMovie(at index: Int) -> Movie? {
        guard index >= 0 && index < movies.count else {
            return nil
        }
        return movies[index]
    }

    func didSelectImage(at index: Int) -> UIImage? {
        guard index >= 0 && index < images.count else {
            return nil
        }
        return images[index]
    }
}
