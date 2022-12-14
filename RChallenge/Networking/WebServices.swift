//
//  WebServices.swift
//  RChallenge
//
//  Created by Guillermo Moral on 12/12/2022.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case decodingError
    case noData
}

class WebServices : API {
    
    func getRestaurant(completion: @escaping (Result<FeedModel?, NetworkError>) -> Void) {
        
        guard let restaurantURL = URL(string: Constants.Urls.allRestaurant()) else {
            completion(.failure(.badURL))
            return
        }
        
        URLSession.shared.dataTask(with: restaurantURL) { data, resonse, error in
            
            guard let data = data, error == nil else {
                completion(.failure(.noData))
                return
            }
            
            let feed = try? JSONDecoder().decode(FeedModel.self, from: data)
            
            if let feed = feed {
                completion(.success(feed))
            } else {
                completion(.failure(.decodingError))
            }
            
        }.resume()
    }
}
