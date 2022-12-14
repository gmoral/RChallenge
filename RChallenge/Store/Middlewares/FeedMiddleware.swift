//
//  FeedMiddleware.swift
//  RChallenge
//
//  Created by Guillermo Moral on 12/12/2022.
//

import Foundation

func feedMiddleware(api: API)-> Middleware<AppState> {
    
    let service : API = api
    
    return { state, action, dispatch in
        switch action {
            case _ as FetchFeed:
                service.getRestaurant() { result in
                    switch result {
                        case .success(let feed):
                            if let feed = feed {
                                dispatch(InsertUpdateFeed(feed: feed.data))
                            }
                        case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            default:
                break
        }
    }
}
