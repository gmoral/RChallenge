//
//  View+Extensions.swift
//  RChallenge
//
//  Created by Guillermo Moral on 12/12/2022.
//

import Foundation
import SwiftUI

extension View {
    func embedInNavigationView() -> some View {
        NavigationView { self }
    }
}
