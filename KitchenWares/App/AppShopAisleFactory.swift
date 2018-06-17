//
//  AppShopAisleFactory.swift
//  KitchenWares
//
//  Created by vic on 16/06/2018.
//  Copyright © 2018 vixac. All rights reserved.
//

import Foundation
import UIKit
class AppShopAisleFactory {
    
}

extension AppShopAisleFactory: ShopAisleFactory {
    
    func interactor() -> ShopAisleInteractorInput {
        
        let fetcher = ItemFetcher(endpoint: URL(string: "https://api.johnlewis.com/v1/products/search?q=dishwasher&key=Wu1Xqn3vNrd1p7hqkvB6hEu0G9OrsYGb&pageSize=20")!)
        let interactor = ShopAisleInteractor(itemFetcher: fetcher)
        return interactor
    }
    
    func presenter(with input: ShopAisleInteractorInput) -> ShopAisleInteractorOutput & ShopAisleEventHandler {
        let presenter = ShopAislePresenter(with: input)
        return presenter
    }
    
    func viewController(with presenter: ShopAisleEventHandler) -> UIViewController {
        let vc = ShopAisleViewController(eventHandler: presenter)
        return vc
    }
    
    func wireframe() -> ShopAisleWireframeProtocol {
        let wireframe = ShopAisleWireframe(with: self)
        return wireframe
    }
}
