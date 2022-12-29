//
//  AggregateRatings.swift
//  RChallenge
//
//  Created by Guillermo Moral on 29/12/2022.
//

import Foundation

struct AggregateRatings : Codable, Equatable {
    let thefork : Thefork?
    let tripadvisor : Tripadvisor?
}
