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
    
}

protocol ShopAisleInteractorOutput: class {
    
}

protocol ShopAisleFactory: class {
    func interactor() -> ShopAisleInteractorInput
    func presenter(with input: ShopAisleInteractorInput) -> ShopAisleInteractorOutput
    func viewController(with presenter: ShopAisleInteractorOutput) -> UIViewController
    func wireframe() -> ShopAisleWireframeProtocol
}
