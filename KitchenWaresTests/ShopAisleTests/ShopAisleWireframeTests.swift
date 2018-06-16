//
//  ShopAisleWireframeTests.swift
//  KitchenWaresTests
//
//  Created by vic on 16/06/2018.
//  Copyright © 2018 vixac. All rights reserved.
//

import XCTest
@testable import KitchenWares

class ShopAisleWireframeTests: XCTestCase {
    
    private var testObject: ShopAisleWireframe!
    private var mockFactory: TestShopAisleFactory!
    override func setUp() {
        super.setUp()
        mockFactory = TestShopAisleFactory()
        testObject = ShopAisleWireframe(with: mockFactory)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    /**
     * When: Display is called
     * Then: The factory viewcontroller should be attached to the window
     */
    func testDisplayUsesFactoryViewController() {
        let window = UIWindow(frame: .zero)
        XCTAssertNil(window.rootViewController)
        testObject.display(in: window)
        XCTAssertNotNil(window.rootViewController)
        XCTAssertEqual(window.rootViewController?.title, "TestViewController")
    }
    
    /**
    * When: Display is called
    * Then: The interactor created by the factory should be passed to the presenter
    */
 
    func testDisplayUsesFactoryInteractor() {
        let window = UIWindow(frame: .zero)
        XCTAssertNil(window.rootViewController)
        testObject.display(in: window)
        XCTAssertTrue(mockFactory.presenterInput === mockFactory.mockInteractor)
        XCTAssertTrue(mockFactory.viewControllersPresenter === mockFactory.mockPresenter)
    }
    
    /**
     * When: Display is called
     * Then: The presenter created by the factory should be passed to the viewcontroller
     */
    func testDisplayUsesFactoryPresenter() {
        let window = UIWindow(frame: .zero)
        XCTAssertNil(window.rootViewController)
        testObject.display(in: window)
        XCTAssertTrue(mockFactory.presenterInput === mockFactory.mockInteractor)
    }
    
}
