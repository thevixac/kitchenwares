//
//  ItemFetcherTests.swift
//  KitchenWaresTests
//
//  Created by vic on 17/06/2018.
//  Copyright © 2018 vixac. All rights reserved.
//

import XCTest

@testable import KitchenWares

class ItemFetcherTests: XCTestCase {
    
    private enum TestError: Error {
        case testError
    }
    var testObject: ItemFetcher!
    var mockParser: MockDishwaserJsonParser!
    var mockSession: MockURLSession!
    override func setUp() {
        super.setUp()
        mockParser = MockDishwaserJsonParser()
        mockSession = MockURLSession()
        testObject = ItemFetcher(endpoint: URL(string: "testUrl")!, parser: mockParser, session: mockSession)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    /**
     * When: Json is correctly returned to the fetcher
     * Then: The shopItems created by the parser should be returned
     */
    func testValidFetch() {
        mockSession.dataToReturn = goodData()
        mockParser.itemToReturn = ShopItem(productId: "id", title: "title", price: 1.0, imagePath: "path")
        let exp = expectation(description: "testValidFetch")
        testObject.fetchItems { result, error in
            XCTAssertNil(error)
            if let result = result {
                exp.fulfill()
                XCTAssertEqual(result.count, 20)
            }
        }
        waitForExpectations(timeout: 1)
    }
    /**
     * When: URLSession returns an error
     * Then: the error  should be propagated as an ItemFetcherError.network
     */
    func testNetworkError() {
        mockSession.errorToReturn = TestError.testError
        let exp = expectation(description: "fetchItemsReturned")
        testObject.fetchItems { result, error in
            XCTAssertNil(result)
            if let error = error {
                if case ItemFetcherError.network(let networkError) = error {
                    if case TestError.testError = networkError {
                        exp.fulfill()
                    }
                }
            }
        }
        waitForExpectations(timeout: 1)
    }
    
    /**
     * When: No data is returned
     * Then: a noData error should be returned
     */
    func testNoData() {
        mockSession.dataToReturn = nil
        let exp = expectation(description: "testNoData")
        testObject.fetchItems { result, error in
            XCTAssertNil(result)
            if let error = error {
                if case ItemFetcherError.noData = error {
                    exp.fulfill()
                }
            }
        }
        waitForExpectations(timeout: 1)
    }
    
    /**
     * When: No data is returned
     * Then: a noData error should be returned
     */
    func testBadData() {
        mockSession.dataToReturn = badData()
        let exp = expectation(description: "testBadData")
        testObject.fetchItems { result, error in
            XCTAssertNil(result)
            if let error = error {
                if case ItemFetcherError.parsingError = error {
                    exp.fulfill()
                }
            }
        }
        waitForExpectations(timeout: 1)
    }
    
    private func badData() -> Data {
        return Data(base64Encoded: "aW52YWxpZGpzb24=")! //thats base64 for "invalidjson"
    }

    private func goodData() -> Data {
        let filePath = Bundle(for: ItemFetcherTests.self).path(forResource: "ProductJson", ofType: "json")!
        let jsonData = NSData(contentsOfFile: filePath)!
        return Data(referencing: jsonData)
    }
    
}
