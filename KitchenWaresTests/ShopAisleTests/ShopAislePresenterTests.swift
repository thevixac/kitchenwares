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
    private var mockView: MockShopAisleView!
    override func setUp() {
        super.setUp()
        mockInteractor = MockShopAisleInteractor()
        mockView = MockShopAisleView()
        testObject = ShopAislePresenter(with: mockInteractor)
        testObject.set(view: mockView)
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
    
    /**
     * When: presenter is notified that an item will appear
     * Then: the interactor should be called to fetch the image
     */
    func testItemAppearingRequestsImage() {
        testObject.itemWillAppear(item: MockItems.shopItem())
        XCTAssertEqual(mockInteractor.imageRequestedItem?.productId, "mockId")
    }
    
    /**
     * When: presenter receives image data
     * Then: the view should receive the image with productId
     */
    func testImageReceivedGoesToView() {
        testObject.imageReceived(productId: "testId", data: MockItems.someData())
        XCTAssertEqual(mockView.displayProductId, "testId")
    }
    
    /**
     * When: presenter receives no image data
     * Then: the view should not receive anything
     */
    func testMissingImageDataGetsIgnored() {
        testObject.imageReceived(productId: "testId", data: nil)
        XCTAssertNil(mockView.displayProductId)
    }
}
