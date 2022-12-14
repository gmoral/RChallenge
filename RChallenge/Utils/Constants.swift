//
//  Constants.swift
//  RChallenge
//
//  Created by Guillermo Moral on 12/12/2022.
//

import Foundation

struct Constants {
    
    struct Api {
        static let root = "https://alanflament.github.io/TFTest/"
    }
    
    struct Urls {
        static func allRestaurant() -> String {
            "\(Api.root)test.json"
        }
    }
}

//https://alanflament.github.io/TFTest/test.json
