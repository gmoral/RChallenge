//
//  RChallengeApp.swift
//  RChallenge
//
//  Created by Guillermo Moral on 13/12/2022.
//

import SwiftUI

@main
struct RChallengeApp: App {
    
    var body: some Scene {
        
        let coreDM = CoreDataManager()
        let service = WebServices()
        
        let store = Store(reducer: appReducer, state: AppState(),
                            middlewares: [feedMiddleware(api: service), coreDataMiddleware(coreDM: coreDM)])
        
        WindowGroup {
            ContentView().environmentObject(store)
        }
    }
}
