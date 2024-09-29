import XCTest
@testable import banquemisr_challenge05_Movies

final class NetworkServiceTests: XCTestCase {
    let network: NetworkRepository = NetworkService()
    
    func testDownloadImageValidURL() {
        let expectation = self.expectation(description: "Downloading image")
        
        network.downloadImage(imageUrl: "\(Constants.imgUrl)\(Constants.validImageUrl)\(Constants.apiKey)") { result in
            switch result {
            case .success(let image):
                XCTAssertNotNil(image, "Image should not be nil")
            case .failure(let error):
                XCTFail("Expected successful image download, but got error: \(error)")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
    }

    func testDownloadImageInvalidURL() {
        let expectation = self.expectation(description: "Downloading image with invalid URL")
        
        network.downloadImage(imageUrl: "invalidImageURL") { result in
            switch result {
            case .success:
                XCTFail("Expected failure but got a successful response")
            case .failure(let error):
                XCTAssertEqual(error as? ErrorMessage, ErrorMessage.invalidResponse, "Expected unableinvalidResponse error")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testFetchDataFromApiValidResponse() {
        let expectation = self.expectation(description: "Fetching movies from API")
        
        network.fetchDataFromApi(movieListType: .popular) { result in
            switch result {
            case .success(let movies):
                XCTAssertFalse(movies.isEmpty, "Movies array should not be empty")
            case .failure(let error):
                XCTFail("Expected successful fetch but got error: \(error)")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
    }

    func testFetchDataFromApiInvalidResponse() {
        let expectation = self.expectation(description: "Fetching movies from API with invalid response")
        
        network.fetchDataFromApi(movieListType: .invalidType) { result in
            switch result {
            case .success:
                XCTFail("Expected failure but got a successful response")
            case .failure(let error):
                XCTAssertEqual(error as? ErrorMessage, ErrorMessage.invalidResponse, "Expected invalidResponse error")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
    }
}
