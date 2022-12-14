//
//  FeedReducer.swift
//  RChallenge
//
//  Created by Guillermo Moral on 12/12/2022.
//

import Foundation

func feedReducer(_ state: FeedState, _ action: Action)-> FeedState {
    var state = state
    
    switch action {
        case let action as SetFeed:
            state.feeds = action.feed
        case let action as SetRestaurant:
            state.restaurants = action.restaurant
        default:
            break
    }
    
    return state
}
