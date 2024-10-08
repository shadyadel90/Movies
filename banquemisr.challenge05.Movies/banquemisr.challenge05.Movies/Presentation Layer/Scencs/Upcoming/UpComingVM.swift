import UIKit

class UpcomingViewModel {
    private var movies: [Movie] = []
    private var imgs: [UIImage] = []
    var reloadTable: (() -> Void)?
    var showError: ((String) -> Void)?
    let network: NetworkRepository = NetworkService()

    func fetchUpcomingMovies() {
        network.fetchDataFromApi(movieListType: .upcoming) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let movies):
                self.movies = movies
                self.imgs = Array(repeating: UIImage(systemName: "photo")!, count: movies.count)
                self.fetchImages()
            case .failure:
                self.showError?(ErrorMessage.unableToComplete.rawValue)
            }
        }
    }

    private func fetchImages() {
        let dispatchGroup = DispatchGroup()

        for (index, item) in movies.enumerated() {
            guard let posterPath = item.poster_path else { continue }
            dispatchGroup.enter()
            let imageUrl = "\(Constants.imgUrl)\(posterPath)\(Constants.apiKey)"
            network.downloadImage(imageUrl: imageUrl) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let image):
                    self.imgs[index] = image
                case .failure:
                    print("Error downloading image for movie: \(item.title ?? "Unknown")")
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

    func didSelectMovie(at index: Int) -> Movie? {
        guard index >= 0 && index < movies.count else {
            return nil
        }
        return movies[index]
    }

    func didSelectImage(at index: Int) -> UIImage? {
        guard index >= 0 && index < imgs.count else {
            return nil
        }
        return imgs[index]
    }
}
