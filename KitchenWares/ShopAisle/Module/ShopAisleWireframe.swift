//
//  ShopAisleWireframe.swift
//  KitchenWares
//
//  Created by vic on 15/06/2018.
//  Copyright © 2018 vixac. All rights reserved.
//

import Foundation
import UIKit

class ShopAisleWireframe {
    private var factory: ShopAisleFactory
    init(with factory: ShopAisleFactory) {
        self.factory = factory
    }
}

extension ShopAisleWireframe: ShopAisleWireframeProtocol {
    func display(in window: UIWindow) {
        let interactor = self.factory.interactor()
        let presenter = self.factory.presenter(with: interactor)
        let viewController = self.factory.viewController(with: presenter)
        window.rootViewController = viewController
    }
}
