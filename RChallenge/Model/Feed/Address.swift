//
//  Address.swift
//  RChallenge
//
//  Created by Guillermo Moral on 29/12/2022.
//

import Foundation

struct Address : Codable, Equatable {
    let street : String
    let postalCode : String
    let locality : String
    let country : String
}
