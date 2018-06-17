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
