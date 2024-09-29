import UIKit

class NowPlayingViewModel {   
    
    private var movies: [Movie] = []
    private var imgs: [UIImage] = []
    var reloadTable: (() -> Void)?
    var showError: ((String) -> Void)?
    let network: NetworkRespository = NetworkService()
    
    func fetchNowPlayingMovies() {
        
        network.fetchDataFromApi(movieListType: .nowPlaying) { [weak self] result in
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
            network.downloadImage(imageUrl: "\(Constants.imgUrl)\(posterPath)\(Constants.apiKey)") { result in
                switch result {
                case .success(let image):
                    self.imgs.append(image)
                case .failure(let error):
                    print(error)
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
        guard index >= 0 && index < imgs.count else {
            return nil
        }
        return imgs[index]
    }
}
