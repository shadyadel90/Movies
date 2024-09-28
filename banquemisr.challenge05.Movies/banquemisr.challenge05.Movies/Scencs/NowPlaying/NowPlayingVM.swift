import UIKit

class NowPlayingViewModel {
    
    var movies: [Movie] = []
    var imgs: [UIImage] = []
    var reloadTable: (() -> Void)?

    func fetchNowPlayingMovies() {
        NetworkService.fetchDataFromApi(movieListType: .nowPlaying) { result in
            switch result {
            case .success(let movies):
                self.movies = movies
                self.fetchImages()
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
            NetworkService.downloadImage(imageUrl: "\(Constants.imgUrl)\(posterPath)\(Constants.apiKey)") { result in
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
}
