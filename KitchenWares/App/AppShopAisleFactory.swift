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
        
        let urls = JohnLewisURL()
        let parser = DishwasherJSONParser()
        let fetcher = ItemFetcher(endpoint: urls.itemFetcherURL(), parser: parser, session: Foundation.URLSession.shared)
        let interactor = ShopAisleInteractor(itemFetcher: fetcher)
        return interactor
    }
    
    func presenter(with input: ShopAisleInteractorInput) -> ShopAisleInteractorOutput & ShopAisleEventHandler {
        let presenter = ShopAislePresenter(with: input)
        input.set(output: presenter)
        return presenter
    }
    
    func viewController(with presenter: ShopAisleEventHandler) -> UIViewController {
        let vc = ShopAisleViewController(eventHandler: presenter)
        presenter.set(view: vc)
        return vc
    }
    
    func wireframe() -> ShopAisleWireframeProtocol {
        let wireframe = ShopAisleWireframe(with: self)
        return wireframe
    }
}
