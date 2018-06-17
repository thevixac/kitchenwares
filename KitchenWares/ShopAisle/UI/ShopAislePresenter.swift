//
//  ShopAislePresenter.swift
//  KitchenWares
//
//  Created by vic on 15/06/2018.
//  Copyright © 2018 vixac. All rights reserved.
//

import Foundation

class ShopAislePresenter {
    private let input: ShopAisleInteractorInput
    private weak var view: ShopAisleView?
    init(with input: ShopAisleInteractorInput) {
        self.input = input
    }
}

extension ShopAislePresenter: ShopAisleEventHandler {
    func itemWillAppear(item: ShopItem) {
        
    }
    
    func viewWillAppear() {
        input.moduleDidLoad()
    }
    
    func set(view: ShopAisleView) {
        self.view = view
    }
}

extension ShopAislePresenter: ShopAisleInteractorOutput {
    func imageReceived(productId: String, data: Data?) {
        
    }
    
    func errorFetchingItems(error: ItemFetcherError) {
        print("presenter errorFetchingItems: \(error)")
    }
    
    func didReceive(items: [ShopItem]) {
        view?.display(items: items)
    }
}
