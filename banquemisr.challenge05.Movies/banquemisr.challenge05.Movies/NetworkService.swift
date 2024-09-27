//
//  NetworkService.swift
//  banquemisr.challenge05.Movies
//
//  Created by Shady Adel on 27/09/2024.
//

import UIKit

class NetworkService {
    
    static func downloadImage(imageUrl: String, completion: @escaping (UIImage?,Error?) -> ()){
        
        let url = URL(string: "\(Constants.imgUrl)\(imageUrl)")
        
        let request = URLRequest(url: url!)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(nil,error)
            }
            
            if let data = data {
                completion(UIImage(data: data),nil)
            }
        }.resume()
        
    }
    
    static func fetchDataFromApi(movieListType: movieListType, completion: @escaping ([Movie]?,Error?) -> ()){
        
        let url = URL(string: "\(Constants.baseUrl)\(movieListType.description)\(Constants.apiKey)")
        
        let request = URLRequest(url: url!)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(nil,error)
            }
            
            if let data = data {
                do {
                    let res = try JSONDecoder().decode(result.self, from: data)
                    completion(res.results,nil)
                }
                catch {
                    completion(nil,error)
                }
            }
            
        }.resume()
    }
}
