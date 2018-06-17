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
    init(with input: ShopAisleInteractorInput) {
        self.input = input
    }
}

extension ShopAislePresenter: ShopAisleEventHandler {
    func viewWillAppear() {
        input.moduleDidLoad()
    }
}

extension ShopAislePresenter: ShopAisleInteractorOutput {
    func errorFetchingItems(error: ItemFetcherError) {
        print("presenter errorFetchingItems: \(error)")
    }
    
    func didReceive(items: [ShopItem]) {
        print("presenter items: \(items)")
    }

}
