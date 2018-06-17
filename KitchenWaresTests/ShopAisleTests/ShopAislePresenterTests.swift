//
//  ShopAislePresenterTests.swift
//  KitchenWaresTests
//
//  Created by vic on 15/06/2018.
//  Copyright © 2018 vixac. All rights reserved.
//

import XCTest
@testable import KitchenWares

class ShopAislePresenterTests: XCTestCase {
    private var testObject: ShopAislePresenter!
    private var mockInteractor: MockShopAisleInteractor!
    override func setUp() {
        super.setUp()
        mockInteractor = MockShopAisleInteractor()
        testObject = ShopAislePresenter(with: mockInteractor)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    /**
     * When: presenter is notified that the view as appeared
     * Then: the interactor should be notified
    */
    func testInteractorGetsModuleDidLoad() {
        testObject.viewWillAppear()
        XCTAssert(mockInteractor.moduleDidLoadCalled)
    }
    
    
    
}
