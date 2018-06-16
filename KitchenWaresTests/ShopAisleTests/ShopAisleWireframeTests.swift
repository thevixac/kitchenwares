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
    override func setUp() {
        super.setUp()
        let factory = TestShopAisleFactory()
        testObject = ShopAisleWireframe(with: factory)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    /**
     * When: Display is called
     * Then: The factory viewcontroller should be attached to the window
     */
    func testDisplayUsesFactorViewController() {
        let window = UIWindow(frame: .zero)
        XCTAssertNil(window.rootViewController)
        testObject.display(in: window)
        XCTAssertNotNil(window.rootViewController)
        XCTAssertEqual(window.rootViewController?.title, "TestViewController")
    }
    
}
