//
//  ShopAisleInteractorTests.swift
//  KitchenWaresTests
//
//  Created by vic on 15/06/2018.
//  Copyright © 2018 vixac. All rights reserved.
//

import XCTest
@testable import KitchenWares

class ShopAisleInteractorTests: XCTestCase {
    
    private var testObject: ShopAisleInteractor!
    private var mockFetcher: MockItemFetcher!
    private var mockPresenter: MockShopAislePresenter!
    override func setUp() {
        super.setUp()
        mockFetcher = MockItemFetcher()
        testObject = ShopAisleInteractor(itemFetcher: mockFetcher)
        mockPresenter = MockShopAislePresenter()
        testObject.output = mockPresenter
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    /**
     * When: Module loads
     * Then: The fetcher should be called to fetch items
     */
    func testFetcherIsCalledWhenModuleLoads() {
        testObject.moduleDidLoad()
        XCTAssert(mockFetcher.fetchCalled)
    }
    
    /**
     * When: ItemFetcher fails
     * Then: The presenter should be passed the error
     */
    func testPresenterGetsFetchErrors() {
        mockFetcher.errorToReturn = ItemFetcherError.parsingError
        testObject.moduleDidLoad()
        let exp = expectation(description: "testPresenterGetsFetchErrors")
        if let error = mockPresenter.errorFromFetching {
            if case ItemFetcherError.parsingError = error {
                exp.fulfill()
            }
        }
        waitForExpectations(timeout: 0)
    }
    
    /**
     * When: ItemFetcher succeeds
     * Then: The presenter should be passed the items to display
     */
    func testPresenterGetsItemsToDisplay() {
        mockFetcher.itemsToReturn = [ShopItem(productId: "id", title: "test1", price: 0.1, imagePath: "test")]
        testObject.moduleDidLoad()
        XCTAssertNotNil(mockPresenter.items)
        XCTAssertEqual(mockPresenter.items?.count, 1)
        XCTAssertEqual(mockPresenter.items?[0].title, "test1")
    }
}
