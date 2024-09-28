import UIKit

class NetworkService {
    
    static func downloadImage(imageUrl: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        guard let url = URL(string: "\(Constants.imgUrl)\(imageUrl)") else {
            completion(.failure(URLError(.badURL)))
            return
        }

        let request = URLRequest(url: url)

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(URLError(.badServerResponse)))
                return
            }

            guard let data = data, let image = UIImage(data: data) else {
                completion(.failure(URLError(.cannotDecodeContentData)))
                return
            }

            completion(.success(image))
        }.resume()
    }
    
    static func fetchDataFromApi(movieListType: movieListType, completion: @escaping (Result<[Movie], Error>) -> Void) {
        
        guard let url = URL(string: "\(Constants.baseUrl)\(movieListType.description)\(Constants.apiKey)") else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        let request = URLRequest(url: url)

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(URLError(.badServerResponse)))
                return
            }

            guard let data = data else {
                completion(.failure(URLError(.unknown)))
                return
            }
            
            do {
                let res = try JSONDecoder().decode(result.self, from: data)
                completion(.success(res.results))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
