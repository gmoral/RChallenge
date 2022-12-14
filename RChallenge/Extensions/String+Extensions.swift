//
//  String+Extensions.swift
//  RChallenge
//
//  Created by Guillermo Moral on 12/12/2022.
//

import Foundation

extension String {
    
    func urlEncode() -> String {
        self.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? self
    }
    
    func toInt() -> Int {
        let ratingDouble = Double(self) ?? 0
        return Int(ratingDouble.rounded())
    }
}
