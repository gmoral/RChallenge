//
//  FeedViewModel.swift
//  RChallenge
//
//  Created by Guillermo Moral on 14/12/2022.
//

import Foundation
import CoreData

struct RestaurantViewModel {
    let restaurant: Restaurant
    
    var id: NSManagedObjectID {
        return restaurant.objectID
    }
    
    var name: String {
        return restaurant.name ?? ""
    }
    
    var uuid: String {
        return restaurant.uuid ?? ""
    }
    
    var servesCuisine: String {
        return restaurant.servesCuisine ?? ""
    }
    
    var currenciesAccepted: String {
        return restaurant.currenciesAccepted ?? ""
    }
    
    var url: String {
        return restaurant.url ?? ""
    }
    
    var priceRange: Double {
        return restaurant.priceRange
    }
    
    var isFavorite: Bool {
        return restaurant.isFavorite
    }
    
    var rating: Double {
        return restaurant.rating
    }
    
    var address: String {
        return restaurant.address ?? ""
    }
}
