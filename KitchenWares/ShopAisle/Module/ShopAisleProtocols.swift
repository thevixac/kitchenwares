//
//  ShopAisleProtocols.swift
//  KitchenWares
//
//  Created by vic on 15/06/2018.
//  Copyright © 2018 vixac. All rights reserved.
//

import Foundation
import UIKit

protocol ShopAisleWireframeProtocol {
    func display(in window: UIWindow)
}

protocol ShopAisleInteractorInput: class {
    func moduleDidLoad()
    func set(output: ShopAisleInteractorOutput)
}

protocol ShopAisleInteractorOutput: class {
    func didReceive(items: [ShopItem])
    func errorFetchingItems(error: ItemFetcherError)
}
protocol ShopAisleEventHandler: class {
    func viewWillAppear()
}

protocol ShopAisleFactory: class {
    func interactor() -> ShopAisleInteractorInput
    func presenter(with input: ShopAisleInteractorInput) -> ShopAisleInteractorOutput & ShopAisleEventHandler
    func viewController(with presenter: ShopAisleEventHandler) -> UIViewController
    func wireframe() -> ShopAisleWireframeProtocol
}
