//
//  ShopAisleMocks.swift
//  KitchenWaresTests
//
//  Created by vic on 16/06/2018.
//  Copyright © 2018 vixac. All rights reserved.
//

import Foundation
import UIKit

@testable import KitchenWares

class MockShopAisleInteractor: ShopAisleInteractorInput {
    
    var imageRequestedItem: ShopItem?
    func imageRequestedFor(item: ShopItem) {
        imageRequestedItem = item
    }

    var moduleDidLoadCalled = false
    func moduleDidLoad() {
        moduleDidLoadCalled = true
    }
    
    var setOutput: ShopAisleInteractorOutput?
    func set(output: ShopAisleInteractorOutput) {
        setOutput = output
    }
}

class MockShopAislePresenter: ShopAisleInteractorOutput, ShopAisleEventHandler {
    var itemToAppear: ShopItem?
    func itemWillAppear(item: ShopItem) {
        itemToAppear = item
    }
    
    var imageProductId: ProductId?
    func imageReceived(productId: ProductId, data: Data?) {
        imageProductId = productId
    }
    
    var errorFromFetching: ItemFetcherError?
    func errorFetchingItems(error: ItemFetcherError) {
        errorFromFetching = error
    }
    
    var items: [ShopItem]?
    func didReceive(items: [ShopItem]) {
        self.items = items
    }
    
    var viewWillAppearCalled = false
    func viewWillAppear() {
        viewWillAppearCalled = true
    }
    
    var setView: ShopAisleView?
    func set(view: ShopAisleView) {
        setView = view
    }
}

class MockShopAisleView: ShopAisleView {
    
    var itemsToDisplay: [ShopItem]?
    func display(items: [ShopItem]) {
        itemsToDisplay = items
    }
    var displayProductId: ProductId?
    func displayImage(productId: ProductId, image: UIImage) {
        displayProductId = productId
    }
}

class MockShopAisleWireframe: ShopAisleWireframeProtocol {
    var displayCalled = false
    func display(in window: UIWindow) {
        displayCalled = true
    }
}

class TestShopAisleFactory: ShopAisleFactory {
    var interactorCalled = false
    let mockInteractor = MockShopAisleInteractor()
    func interactor() -> ShopAisleInteractorInput {
        interactorCalled = true
        return mockInteractor
    }
    var presenterCalled = false
    var presenterInput: ShopAisleInteractorInput?
    let mockPresenter = MockShopAislePresenter()
    func presenter(with input: ShopAisleInteractorInput) -> ShopAisleInteractorOutput & ShopAisleEventHandler {
        presenterCalled = true
        presenterInput = input
        return mockPresenter
    }
    
    var viewControllerCalled = false
    var viewControllersPresenter: ShopAisleEventHandler?
    func viewController(with presenter: ShopAisleEventHandler) -> UIViewController {
        viewControllerCalled = true
        viewControllersPresenter = presenter
        let testViewController = UIViewController()
        testViewController.title = "TestViewController"
        return testViewController
    }
    
    var wireframeCalled = false
    func wireframe() -> ShopAisleWireframeProtocol {
        wireframeCalled = true
        return MockShopAisleWireframe()
    }
}

class MockItems {
    class func shopItem(productId: ProductId = "mockId",
                        title: String = "title",
                        price: Float = 123.34,
                        imagePath: String = "imagePath") -> ShopItem {
        return ShopItem(productId: productId, title: title, price: price, imagePath: imagePath)
    }
    
    class func someData() -> Data {
        return Data(base64Encoded: "aW52YWxpZGpzb24=")! //thats base64 for "invalidjson"
    }
}
