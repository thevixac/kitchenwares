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
    
}

class MockShopAislePresenter: ShopAisleInteractorOutput {
    
}

class MockShopAisleWireframe: ShopAisleWireframeProtocol {
    var displayCalled = false
    func display(in window: UIWindow) {
        self.displayCalled = true
    }
}

class TestShopAisleFactory: ShopAisleFactory {
    
    var interactorCalled = false
    func interactor() -> ShopAisleInteractorInput {
        self.interactorCalled = true
        return MockShopAisleInteractor()
    }
    var presenterCalled = false
    func presenter(with input: ShopAisleInteractorInput) -> ShopAisleInteractorOutput {
        self.presenterCalled = true
        return MockShopAislePresenter()
    }
    
    var viewControllerCalled = false
    func viewController(with presenter: ShopAisleInteractorOutput) -> UIViewController {
        self.viewControllerCalled = true
        let testViewController = UIViewController()
        testViewController.title = "TestViewController"
        return testViewController
    }
    
    var wireframeCalled = false
    func wireframe() -> ShopAisleWireframeProtocol {
        self.wireframeCalled = true
        return MockShopAisleWireframe()
    }
}
