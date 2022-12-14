//
//  RChallengeTests.swift
//  RChallengeTests
//
//  Created by Guillermo Moral on 13/12/2022.
//

import XCTest
@testable import RChallenge
import Nimble


final class RChallengeTests: XCTestCase {
    // Given
    let coreDM = CoreDataManager()
    
    func test_delete_db() {
        // When
        coreDM.clean()
        let result = coreDM.getAllRestaurant()
        
        // Then
        XCTAssertEqual(result.count, 0)
    }
    
    func test_api() {
        // Given
        describe("The api before call the services") {
            
            var service : API
            var result : [Feed]
            
            // When
            beforeEach {
               service = WebServices()
               
               service.getRestaurant() { result in
                   switch result {
                       case .success(let feed):
                           if let feed = feed {
                               result = feed.data
                           }
                       case .failure(let error):
                       print(error.localizedDescription)
                   }
               }
            }
            
            // Then
            context("When feed is given") {
                it("Result should have a feed") {
                    expect(result.count()).to(beGreaterThan(0))
                }
            }
        }
    }
}
