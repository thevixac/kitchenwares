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
        testObject.itemWillAppear(item: MockItems.shopItemDisplayable(productId: "testId", imagePath: "//testPath"))
        XCTAssertEqual(mockInteractor.imageProductId, "testId")
        XCTAssertEqual(mockInteractor.imagePath, "//testPath")
    }
    
    /**
     * When: presenter receives image data
     * Then: the view should receive the image with productId
     * And: the image should be passed in
     */
    func testImageReceivedGoesToView() {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 10))
        view.backgroundColor = .red
        let image = viewToImage(view: view)
        let data = UIImagePNGRepresentation(image)
        testObject.imageReceived(productId: "testId", data: data)
        XCTAssertEqual(mockView.displayProductId, "testId")
        XCTAssertEqual(mockView.passedImage?.size.width, 40)
    }
    
    /**
     * When: presenter receives no image data
     * Then: the view should not receive anything
     */
    func testMissingImageDataGetsIgnored() {
        testObject.imageReceived(productId: "testId", data: nil)
        XCTAssertNil(mockView.displayProductId)
    }
    
    private func viewToImage(view: UIView) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 1.0)
        defer { UIGraphicsEndImageContext() }
        let context = UIGraphicsGetCurrentContext()!
        view.layer.render(in: context)
        return UIGraphicsGetImageFromCurrentImageContext()!
    }
}
