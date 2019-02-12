//
//  TestJSONParser.swift
//  FoodFinderTests
//
//  Created by Ahmed Askar on 2/12/19.
//  Copyright © 2019 Ahmed Askar. All rights reserved.
//

import XCTest

@testable import FoodFinder

class ParserHelperTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testParseJson(){
        let testParseExpectation = expectation(description: "testParse")
        do {
             let result: ResturantModel = try ParserHelper.parseJson("resturantsMock")
            XCTAssertNotNil(result)
            XCTAssertEqual(result.restaurants.count, 5)
            testParseExpectation.fulfill()
        } catch {
            XCTAssertNotNil(error)
        }
        waitForExpectations(timeout: 2, handler: nil)
    }

}
