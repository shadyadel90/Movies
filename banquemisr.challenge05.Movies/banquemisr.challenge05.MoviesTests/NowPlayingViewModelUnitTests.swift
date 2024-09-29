import XCTest
@testable import banquemisr_challenge05_Movies

final class NowPlayingViewModelUnitTests: XCTestCase {
    
    var viewModel: NowPlayingViewModel!
    var mockNetworkService: MockNetworkService!
    
    override func setUp() {
        super.setUp()
        mockNetworkService = MockNetworkService()
        viewModel = NowPlayingViewModel()
        viewModel.network = mockNetworkService
    }
    
    override func tearDown() {
        viewModel = nil
        mockNetworkService = nil
        super.tearDown()
    }
    
    func testFetchNowPlayingMoviesSuccess() {
        let expectation = self.expectation(description: "Reload Table is called")
        mockNetworkService.mockMovies = [
            Movie(genre_ids: [28], popularity: 100.0, poster_path: "path/to/poster1", overview: "Overview 1", title: "Movie 1", release_date: "2024-01-01"),
            Movie(genre_ids: [12], popularity: 200.0, poster_path: "path/to/poster2", overview: "Overview 2", title: "Movie 2", release_date: "2024-02-01")
        ]
        viewModel.reloadTable = {
            expectation.fulfill()
        }
        
        viewModel.fetchNowPlayingMovies()
        
        waitForExpectations(timeout: 1) { error in
            XCTAssertNil(error)
            XCTAssertEqual(self.viewModel.numberOfMovies(), 2)
        }
    }
    
    func testFetchNowPlayingMoviesFailure() {
        let expectation = self.expectation(description: "Show Error is called")
        mockNetworkService.shouldReturnError = true
        viewModel.showError = { errorMessage in
            XCTAssertEqual(errorMessage, ErrorMessage.unableToComplete.rawValue)
            expectation.fulfill()
        }
        
        viewModel.fetchNowPlayingMovies()
        
        waitForExpectations(timeout: 1) { error in
            XCTAssertNil(error)
        }
    }
    
    func testFetchImagesSuccess() {
        let expectation = self.expectation(description: "Reload Table is called")
        mockNetworkService.mockMovies = [
            Movie(genre_ids: [28], popularity: 100.0, poster_path: "path/to/poster1", overview: "Overview 1", title: "Movie 1", release_date: "2024-01-01")
        ]
        mockNetworkService.mockImage = UIImage()
        viewModel.reloadTable = {
            expectation.fulfill()
        }
        
        viewModel.fetchNowPlayingMovies()
        
        waitForExpectations(timeout: 1) { error in
            XCTAssertNil(error)
            XCTAssertEqual(self.viewModel.didSelectImage(at: 0), self.mockNetworkService.mockImage)
        }
    }
    
    func testFetchImagesFailure() {
        let expectation = self.expectation(description: "Image download error is handled")
        mockNetworkService.mockMovies = [
            Movie(genre_ids: [28], popularity: 100.0, poster_path: "path/to/poster1", overview: "Overview 1", title: "Movie 1", release_date: "2024-01-01")
        ]
        mockNetworkService.mockImage = nil
        viewModel.reloadTable = {
            expectation.fulfill()
        }
        
        viewModel.fetchNowPlayingMovies()
        
        waitForExpectations(timeout: 5) { error in
            XCTAssertNil(error)
            XCTAssertNil(self.viewModel.didSelectImage(at: 0))
        }
    }
    
    class MockNetworkService: NetworkRepository {
        
        var shouldReturnError = false
        var mockMovies: [Movie] = []
        var mockImage: UIImage?
        
        func fetchDataFromApi(movieListType: MovieListType, completion: @escaping (Result<[Movie], Error>) -> Void) {
            if shouldReturnError {
                completion(.failure(MockError.networkError))
            } else {
                completion(.success(mockMovies))
            }
        }
        
        func downloadImage(imageUrl: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
            if let image = mockImage {
                completion(.success(image))
            } else {
                completion(.failure(MockError.imageDownloadError))
            }
        }
    }

    enum MockError: Error {
        case networkError
        case imageDownloadError
    }
}
