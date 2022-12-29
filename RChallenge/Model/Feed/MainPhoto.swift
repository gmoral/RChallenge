//
//  MainPhoto.swift
//  RChallenge
//
//  Created by Guillermo Moral on 29/12/2022.
//

import Foundation

struct MainPhoto : Codable, Equatable {
    let url : String
    
    private enum CodingKeys: String, CodingKey {
        case url = "source"
    }
}
