//
//  CoreDataManager.swift
//  RChallenge
//
//  Created by Guillermo Moral on 13/12/2022.
//

import Foundation
import CoreData

class CoreDataManager : CoreDataFeed {
    
    private let persistentContainer : NSPersistentContainer
    private let context : NSManagedObjectContext
    
    init() {
        persistentContainer = NSPersistentContainer(name: "db")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Failure to initial Core Data \(error)")
            }
        }
        
        context = persistentContainer.viewContext
    }
    
    func getAllRestaurant() -> [Restaurant] {
        let fetchRequest : NSFetchRequest<Restaurant> = Restaurant.fetchRequest()
        
        do {
            return try context.fetch(fetchRequest)
        } catch {
            return []
        }
    }
    
    func getRestaurantByUUID(uuid: String) -> [Restaurant]  {
        
        let request : NSFetchRequest<Restaurant> = Restaurant.fetchRequest()
        request.predicate = NSPredicate(format: "uuid CONTAINS %@", uuid)
        
        do {
            return try context.fetch(request)
        } catch {
            return []
        }
    }
    
    func updateRestaurantByFavorite(uuid: String, isFavorite: Bool) {
        
        let request : NSFetchRequest<Restaurant> = Restaurant.fetchRequest()
        request.predicate = NSPredicate(format: "uuid CONTAINS %@", uuid)
        
        do {
            let result = try context.fetch(request)
            let r = result.first
            r?.isFavorite = isFavorite
            self.save()
        } catch {
            print("Update restaurant error")
        }
    }
        
    func insertUpdateRestaurant(feeds: [Feed]) {
        
        for feed in feeds {
            
            let restaurant = getRestaurantByUUID(uuid: feed.uuid)
            
            if restaurant.count == 0 {
                let restaurant = Restaurant(context: context)
                restaurant.name = feed.name
                restaurant.uuid = feed.uuid
                restaurant.isFavorite = false
                restaurant.url = "https://res.cloudinary.com/tf-lab/image/upload/restaurant/3da6a3db-1080-4e1e-8438-1e82ca838100/ff083b11-2a3a-4b4c-8e92-21ef2afe712a.jpg"
                restaurant.priceRange = feed.priceRange
                restaurant.currenciesAccepted = feed.currenciesAccepted
                restaurant.servesCuisine = feed.servesCuisine
                restaurant.rating = 3
                restaurant.address = "\(feed.address.street), \(feed.address.locality)"
            }
        }
        
        self.save()
    }
    
    func save() {
        do {
            try context.save()
        } catch {
            context.rollback()
            print("Failure to save a restaurant \(error)")
        }
    }
    
    func clean() {
        
        let fetchRequest : NSFetchRequest<Restaurant> = Restaurant.fetchRequest()
        
        do {
            let restaurants = try context.fetch(fetchRequest)
            for restaurant in restaurants {
                context.delete(restaurant)
            }
        } catch {
            print("Failure to clean a restaurant \(error)")
        }
        
        self.save()
    }
}
