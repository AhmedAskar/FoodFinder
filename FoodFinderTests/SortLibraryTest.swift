//
//  SortLibraryTest.swift
//  FoodFinderTests
//
//  Created by Ahmed Askar on 2/12/19.
//  Copyright © 2019 Ahmed Askar. All rights reserved.
//

import XCTest

@testable import FoodFinder

class SortLibraryTest: XCTestCase {

    var restaurants : [Resturant] = []
    var sortLib: SortLibrary = SortLibrary()
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        do {
            let result: ResturantModel = try ParserHelper.parseJson("resturantsMock")
            XCTAssertNotNil(result)
            XCTAssertEqual(result.restaurants.count, 5)
            self.restaurants = result.restaurants
        } catch {
            XCTAssertNotNil(error)
        }
    }
    
    func testSortbyOpeningState() {
        let result = sortLib.sortbyOpeningState(restaurants)
        XCTAssertNotNil(result)
        XCTAssertEqual(result.count, 5)
        let stateResult = result.map { $0.status }
        XCTAssertEqual(stateResult.count, 5)
        XCTAssertEqual(stateResult[0], "open")
        XCTAssertEqual(stateResult[1], "open")
        XCTAssertEqual(stateResult[2], "open")
        XCTAssertEqual(stateResult[3], "order ahead")
        XCTAssertEqual(stateResult[4], "closed")
    }
    
    func testSortbyOptionBestMatch() {
        let result = sortLib.sortbyOption(restaurants, .bestMatch)
        XCTAssertNotNil(result)
        XCTAssertEqual(result.count, 5)
        let bestMatchResult = result.map { $0.name }
        XCTAssertEqual(bestMatchResult[0], "Resturant 5")
        XCTAssertEqual(bestMatchResult[1], "Resturant 4")
        XCTAssertEqual(bestMatchResult[2], "Resturant 3")
        XCTAssertEqual(bestMatchResult[3], "Resturant 2")
        XCTAssertEqual(bestMatchResult[4], "Resturant 1")
    }
    
    func testSortbyOptionPrice() {
        let result = sortLib.sortbyOption(restaurants, .price)
        XCTAssertNotNil(result)
        XCTAssertEqual(result.count, 5)
        let priceResult = result.map { $0.name }
        XCTAssertEqual(priceResult[0], "Resturant 1")
        XCTAssertEqual(priceResult[1], "Resturant 3")
        XCTAssertEqual(priceResult[2], "Resturant 4")
        XCTAssertEqual(priceResult[3], "Resturant 2")
        XCTAssertEqual(priceResult[4], "Resturant 5")
    }
    
    func testSortbyOptionDeliveryCosts() {
        let result = sortLib.sortbyOption(restaurants, .deliveryCosts)
        XCTAssertNotNil(result)
        XCTAssertEqual(result.count, 5)
        let deliveryCostsResult = result.map { $0.name }
        XCTAssertEqual(deliveryCostsResult[0], "Resturant 1")
        XCTAssertEqual(deliveryCostsResult[1], "Resturant 2")
        XCTAssertEqual(deliveryCostsResult[2], "Resturant 3")
        XCTAssertEqual(deliveryCostsResult[3], "Resturant 4")
        XCTAssertEqual(deliveryCostsResult[4], "Resturant 5")
    }
    
    func testSortbyOptionDistance() {
        let result = sortLib.sortbyOption(restaurants, .distance)
        XCTAssertNotNil(result)
        XCTAssertEqual(result.count, 5)
        let distanceResult = result.map { $0.name }
        XCTAssertEqual(distanceResult[0], "Resturant 3")
        XCTAssertEqual(distanceResult[1], "Resturant 2")
        XCTAssertEqual(distanceResult[2], "Resturant 5")
        XCTAssertEqual(distanceResult[3], "Resturant 4")
        XCTAssertEqual(distanceResult[4], "Resturant 1")
    }
    
    func testSortbyOptionMinCost() {
        let result = sortLib.sortbyOption(restaurants, .minCost)
        XCTAssertNotNil(result)
        XCTAssertEqual(result.count, 5)
        let minCostResult = result.map { $0.name }
        XCTAssertEqual(minCostResult[0], "Resturant 3")
        XCTAssertEqual(minCostResult[1], "Resturant 5")
        XCTAssertEqual(minCostResult[2], "Resturant 2")
        XCTAssertEqual(minCostResult[3], "Resturant 4")
        XCTAssertEqual(minCostResult[4], "Resturant 1")
    }
    
    func testSortbyOptionNewest() {
        let result = sortLib.sortbyOption(restaurants, .newest)
        XCTAssertNotNil(result)
        XCTAssertEqual(result.count, 5)
        let newestResult = result.map { $0.name }
        XCTAssertEqual(newestResult[0], "Resturant 2")
        XCTAssertEqual(newestResult[1], "Resturant 5")
        XCTAssertEqual(newestResult[2], "Resturant 4")
        XCTAssertEqual(newestResult[3], "Resturant 3")
        XCTAssertEqual(newestResult[4], "Resturant 1")
    }
    
    func testSortbyOptionPopularity() {
        let result = sortLib.sortbyOption(restaurants, .popularity)
        XCTAssertNotNil(result)
        XCTAssertEqual(result.count, 5)
        let popularityResult = result.map { $0.name }
        XCTAssertEqual(popularityResult[0], "Resturant 2")
        XCTAssertEqual(popularityResult[1], "Resturant 5")
        XCTAssertEqual(popularityResult[2], "Resturant 3")
        XCTAssertEqual(popularityResult[3], "Resturant 4")
        XCTAssertEqual(popularityResult[4], "Resturant 1")
    }
    
    func testSortbyOptionRatingAverage() {
        let result = sortLib.sortbyOption(restaurants, .ratingAverage)
        let ratingAverageResult = result.map { $0.name }
        XCTAssertEqual(ratingAverageResult[0], "Resturant 1")
        XCTAssertEqual(ratingAverageResult[1], "Resturant 2")
        XCTAssertEqual(ratingAverageResult[2], "Resturant 3")
        XCTAssertEqual(ratingAverageResult[3], "Resturant 5")
        XCTAssertEqual(ratingAverageResult[4], "Resturant 4")
    }
    
}
