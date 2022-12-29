//
//  Feed.swift
//  RChallenge
//
//  Created by Guillermo Moral on 29/12/2022.
//

import Foundation

struct Feed: Codable {
    let name: String
    let uuid: String
    let servesCuisine: String
    let priceRange : Int
    let currenciesAccepted : String
    let address: Address?
    let aggregateRatings : AggregateRatings?
    let mainPhoto : MainPhoto?
    let bestOffer : BestOffer?
}
