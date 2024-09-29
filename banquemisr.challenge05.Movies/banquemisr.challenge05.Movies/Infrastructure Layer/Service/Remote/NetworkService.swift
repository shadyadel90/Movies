import UIKit

class NetworkService: NetworkRespository {
    
    func downloadImage(imageUrl: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        guard let url = URL(string: "\(Constants.imgUrl)\(imageUrl)") else {
            completion(.failure(ErrorMessage.unableToComplete))
            return
        }

        let request = URLRequest(url: url)

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let _ = error {
                completion(.failure(ErrorMessage.invalidRequest))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(ErrorMessage.invalidResponse))
                return
            }

            guard let data = data, let image = UIImage(data: data) else {
                completion(.failure(ErrorMessage.invalidData))
                return
            }

            completion(.success(image))
        }.resume()
    }
    
    func fetchDataFromApi(movieListType: movieListType, completion: @escaping (Result<[Movie], Error>) -> Void) {
        
        guard let url = URL(string: "\(Constants.baseUrl)\(movieListType.description)\(Constants.apiKey)") else {
            completion(.failure(ErrorMessage.unableToComplete))
            return
        }
        
        let request = URLRequest(url: url)

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let _ = error {
                completion(.failure(ErrorMessage.invalidRequest))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(ErrorMessage.invalidResponse))
                return
            }

            guard let data = data else {
                completion(.failure(ErrorMessage.invalidData))
                return
            }
            
            do {
                let res = try JSONDecoder().decode(result.self, from: data)
                completion(.success(res.results))
            } catch {
                completion(.failure(ErrorMessage.unableToComplete))
            }
        }.resume()
    }
}
