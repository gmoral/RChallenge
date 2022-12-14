//
//  CoreDataMiddleware.swift
//  RChallenge
//
//  Created by Guillermo Moral on 14/12/2022.
//

import Foundation

func coreDataMiddleware(coreDM: CoreDataFeed)-> Middleware<AppState> {
    
    let cdm : CoreDataFeed = coreDM
    
    return { state, action, dispatch in
        switch action {
            case _ as FetchRestaurant:
                let restaurants = cdm.getAllRestaurant()
                DispatchQueue.main.async {
                    let restaurantsVM = restaurants.map(RestaurantViewModel.init)
                    dispatch(SetRestaurant(restaurant: restaurantsVM))
                }
        case let action as InsertUpdateFeed:
            DispatchQueue.main.async {
                cdm.insertUpdateRestaurant(feeds: action.feed)
                dispatch(FetchRestaurant())
            }
        case let action as UpdateFavorite:
            cdm.updateRestaurantByFavorite(uuid: action.restaurant.uuid, isFavorite: !action.restaurant.isFavorite)
                dispatch(FetchRestaurant())
            default:
                break
        }
    }
}
