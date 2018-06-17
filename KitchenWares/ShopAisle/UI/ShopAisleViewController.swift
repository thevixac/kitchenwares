//
//  ShopAisleViewController.swift
//  KitchenWares
//
//  Created by vic on 15/06/2018.
//  Copyright © 2018 vixac. All rights reserved.
//

import Foundation
import UIKit

class ShopAisleViewController: UIViewController {
    private let eventHandler: ShopAisleEventHandler
    
    init(eventHandler: ShopAisleEventHandler) {
        self.eventHandler = eventHandler
        let bundle = Bundle(for: ShopAisleViewController.self)
        super.init(nibName: "ShopAisleViewController", bundle: bundle)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.eventHandler.viewWillAppear()
    }
}
