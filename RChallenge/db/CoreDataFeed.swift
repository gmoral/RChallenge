//
//  CoreDataFeed.swift
//  RChallenge
//
//  Created by Guillermo Moral on 14/12/2022.
//

protocol CoreDataFeed {
    func getAllRestaurant() -> [Restaurant]
    func getRestaurantByUUID(uuid: String) -> [Restaurant]
    func updateRestaurantByFavorite(uuid: String, isFavorite: Bool)
    func insertUpdateRestaurant(feeds: [Feed])
    func save()
    func clean() 
}
