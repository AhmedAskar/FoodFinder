//
//  ResturantViewModelTest.swift
//  FoodFinderTests
//
//  Created by Ahmed Askar on 2/12/19.
//  Copyright © 2019 Ahmed Askar. All rights reserved.
//

import XCTest

@testable import FoodFinder

class ResturantViewModelTest: XCTestCase {
    
    var dataSource: ResturantDataSourceProtocol!
    var viewModel: ResturantViewModel!
    var resturants : [Resturant] = []

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        dataSource = ResturantDataSource()
        viewModel = ResturantViewModel(dataSource: dataSource)
        do {
            let result: ResturantModel = try ParserHelper.parseJson("resturantsMock")
            self.resturants = result.restaurants
        } catch {
            XCTAssertNotNil(error)
        }
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        dataSource = nil
        viewModel = nil
    }

    func testGetResturant() {
        let testParseExpectation = expectation(description: "testGetResturant")
        dataSource.getFilteredResturants(.bestMatch) {(result) in
            switch result{
            case .success(let resturants):
                XCTAssertNotNil(resturants)
                testParseExpectation.fulfill()
            case .error(let error):
                XCTAssertNotNil(error)
            }
        }
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testGetResturantModel() {
        viewModel.resturantModels = resturants
        let indexPath = IndexPath(row: 1, section: 0)
        let resturant = viewModel.getResturantModel(at: indexPath)
        let testResturant = resturants[indexPath.row]
        XCTAssertEqual(resturant.name, testResturant.name)
    }
    
    func testNumberOfCells() {
        viewModel.resturantModels = resturants
        let count = viewModel.numberOfCells
        XCTAssertEqual(count, resturants.count)
    }
    
    func testSearchResutrants() {
        viewModel.resturants = resturants
        viewModel.searchResutrants(.search("Resturant 5"))
        XCTAssertEqual(viewModel.resturantModels.count, 1)
        let resturant = viewModel.resturantModels.first!
        XCTAssertEqual(resturant.name, "Resturant 5")
    }
    
}
