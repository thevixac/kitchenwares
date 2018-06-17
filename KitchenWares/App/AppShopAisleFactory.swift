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
        let fetcher = ItemFetcher(endpoint: URL(fileURLWithPath: "TODO"))
        let interactor = ShopAisleInteractor(itemFetcher: fetcher)
        return interactor
    }
    
    func presenter(with input: ShopAisleInteractorInput) -> ShopAisleInteractorOutput & ShopAisleEventHandler {
        let presenter = ShopAislePresenter(with: input)
        return presenter
    }
    
    func viewController(with presenter: ShopAisleInteractorOutput) -> UIViewController {
        let vc = UIViewController()
        vc.view.backgroundColor = .red
        return vc
    }
    
    func wireframe() -> ShopAisleWireframeProtocol {
        let wireframe = ShopAisleWireframe(with: self)
        return wireframe
    }
}
