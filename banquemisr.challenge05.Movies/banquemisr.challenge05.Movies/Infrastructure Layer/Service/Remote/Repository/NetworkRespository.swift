

import UIKit

protocol NetworkRespository {
    
    func downloadImage(imageUrl: String, completion: @escaping (Result<UIImage, Error>) -> Void)
    
    func fetchDataFromApi(movieListType: movieListType, completion: @escaping (Result<[Movie], Error>) -> Void)
}
