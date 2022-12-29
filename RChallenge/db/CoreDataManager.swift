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
    
    init(inMemory: Bool = false) {
        persistentContainer = NSPersistentContainer(name: "db")
        
        if inMemory {
            persistentContainer.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        } else {
            
            persistentContainer.loadPersistentStores { (description, error) in
                if let error = error {
                    fatalError("Failure to initial Core Data \(error)")
                }
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
                restaurant.url = feed.mainPhoto?.url ?? ""
                restaurant.priceRange = Double(feed.priceRange)
                restaurant.currenciesAccepted = feed.currenciesAccepted
                restaurant.servesCuisine = feed.servesCuisine
                restaurant.rating = feed.aggregateRatings?.thefork?.ratingValue ?? 0
                
                if let address = feed.address {
                    restaurant.address = address.street
                }
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
