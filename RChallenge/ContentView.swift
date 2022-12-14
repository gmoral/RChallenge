//
//  ContentView.swift
//  RChallenge
//
//  Created by Guillermo Moral on 13/12/2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct ContentView: View {
    @EnvironmentObject var store: Store<AppState>
    
    struct Props {
        let restaurants: [RestaurantViewModel]
        let onFetchFeed: ()-> Void
    }
    
    private func map(state: FeedState) -> Props {
        Props(restaurants: state.restaurants,
              onFetchFeed: {store.dispatch(action: FetchFeed())
        })
    }
        
   
    var body: some View {
        let props = map(state: store.state.feedState)
            VStack {
                List(props.restaurants, id: \.uuid) { restaurant in
                    FeedCell(restaurant: restaurant).environmentObject(store)
                }.listStyle(PlainListStyle())
            }
            .navigationTitle("Restaurants")
            .embedInNavigationView()
            
            .onAppear(perform: {
                props.onFetchFeed()
            })
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let store = Store(reducer: appReducer, state: AppState(), middlewares: [feedMiddleware(api: WebServices())])

        return ContentView().environmentObject(store)
    }
}

struct FeedCell: View {
    
    @EnvironmentObject var store: Store<AppState>
    
    let restaurant: RestaurantViewModel
    
    struct Props {
        let onUpdateFavorite: (RestaurantViewModel) -> ()
    }
    
    private func map(state: FeedState) -> Props {
        return Props(onUpdateFavorite: { restaurant in
            store.dispatch(action: UpdateFavorite(restaurant: restaurant))
        })
    }
    
    var body: some View {
        let props = map(state: store.state.feedState)
        HStack (alignment:.top) {
            WebImage(url: URL(string: restaurant.url))
                        .resizable()
                        .frame(width: 80, height: 100)
                        .aspectRatio(contentMode: .fit)
            VStack (alignment:.leading) {
                HStack () {
                    Button () {
                        props.onUpdateFavorite(restaurant)
                    } label: {
                        if restaurant.isFavorite {
                            Image("filled-heart")
                        } else {
                            Image("empty-heart")
                        }
                    }
                    Text(restaurant.name)
                }
                Spacer()
                Text(restaurant.address)
                RatingView(rating: .constant(Int(restaurant.rating)))
                    .frame(alignment: .bottom)
            }
        }
    }
}
