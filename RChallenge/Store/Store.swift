//
//  Store.swift
//  RChallenge
//
//  Created by Guillermo Moral on 12/12/2022.
//

import Foundation

typealias Dispatcher = (Action) -> Void
typealias Reducer<State: ReduxState> = (_ state: State, _ action: Action)-> State
typealias Middleware<StoreState: ReduxState> = (StoreState, Action, @escaping Dispatcher) -> Void

// States
protocol ReduxState {}

struct AppState:  ReduxState {
    var feedState = FeedState()
}

struct FeedState: ReduxState {
    var feeds: [Feed] = [Feed]()
    var restaurants: [RestaurantViewModel] = [RestaurantViewModel]()
}

// Actions
protocol Action { }

struct SetFeed: Action {
    var feed : [Feed]
}

struct InsertUpdateFeed: Action {
    var feed : [Feed]
}

struct SetRestaurant: Action {
    var restaurant : [RestaurantViewModel]
}

struct FetchFeed: Action { }

struct FetchRestaurant: Action { }

struct UpdateFavorite: Action {
    let restaurant : RestaurantViewModel
}

class Store<StoreState: ReduxState>: ObservableObject {
    
    @Published var state: StoreState
    var reducer: Reducer<StoreState>
    var middlewares: [Middleware<StoreState>]
    
    init(reducer: @escaping Reducer<StoreState>, state: StoreState, middlewares: [Middleware<StoreState>] = []) {
        self.reducer = reducer
        self.state = state
        self.middlewares = middlewares
    }
    
    func dispatch(action: Action) {
        
        DispatchQueue.main.async {
            self.state = self.reducer(self.state, action)
        }
        
        // run all middlewares
        middlewares.forEach { middleware in
            middleware(state, action, dispatch)
        }
    }
}
