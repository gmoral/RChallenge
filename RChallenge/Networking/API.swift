//
//  API.swift
//  RChallenge
//
//  Created by Guillermo Moral on 14/12/2022.
//

import Foundation

protocol API {
    func getRestaurant(completion: @escaping (Result<FeedModel?, NetworkError>) -> Void)
}
