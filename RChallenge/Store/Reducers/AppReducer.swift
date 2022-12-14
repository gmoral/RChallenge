//
//  AppReducer.swift
//  Counter
//
//  Created by Guillermo Moral on 12/12/2022.
//

import Foundation

func appReducer(_ state: AppState, _ action: Action)-> AppState {
    var state = state
    
    state.feedState = feedReducer(state.feedState, action)
    
    return state
}
