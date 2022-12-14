//
//  Restaurant.swift
//  RChallenge
//
//  Created by Guillermo Moral on 13/12/2022.
//

import Foundation

struct FeedModel: Codable {
    let data : [Feed]
    
    enum CodingKeys: String, CodingKey {
        case data
    }
}

struct Address : Codable {
    let street : String
    let postalCode : String
    let locality : String
    let country : String
}

struct Thefork : Codable {
    let ratingValue : Double
    let reviewCount : Double
}

struct Tripadvisor : Codable {
    let ratingValue : Double
    let reviewCount : Double
}

struct Feed: Codable {
    
    let name: String
    let uuid: String
    let servesCuisine: String
    let priceRange: Double
    let currenciesAccepted: String
    let address: Address
    let bestOffer: [String : String]
}
