//
//  ShopAisleProtocols.swift
//  KitchenWares
//
//  Created by vic on 15/06/2018.
//  Copyright © 2018 vixac. All rights reserved.
//

import Foundation
import UIKit

typealias ProductId = String
protocol ShopAisleWireframeProtocol {
    func display(in window: UIWindow)
}

protocol ShopAisleInteractorInput: class {
    func moduleDidLoad()
    func set(output: ShopAisleInteractorOutput)
    func imageRequestedFor(productId: ProductId, imagePath: String)
}

protocol ShopAisleInteractorOutput: class {
    func didReceive(items: [ShopItem])
    func errorFetchingItems(error: ItemFetcherError)
    func imageReceived(productId: ProductId, data: Data?)
}

protocol ShopAisleEventHandler: class {
    func viewWillAppear()
    func set(view: ShopAisleView)
    func itemWillAppear(item: ShopItemDisplayable)
}

protocol ShopAisleFactory: class {
    func interactor() -> ShopAisleInteractorInput
    func presenter(with input: ShopAisleInteractorInput) -> ShopAisleInteractorOutput & ShopAisleEventHandler
    func viewController(with presenter: ShopAisleEventHandler) -> UIViewController
    func wireframe() -> ShopAisleWireframeProtocol
}

protocol ShopAisleView: class {
    func display(items: [ShopItemDisplayable])
    func displayImage(identifier: String, image: UIImage)
}
