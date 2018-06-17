//
//  ShopAisleInteractor.swift
//  KitchenWares
//
//  Created by vic on 15/06/2018.
//  Copyright © 2018 vixac. All rights reserved.
//

import Foundation

class ShopAisleInteractor {
    weak var output: ShopAisleInteractorOutput?
    private let itemFetcher: ItemFetcherProtocol
    
    init(itemFetcher: ItemFetcherProtocol) {
        self.itemFetcher = itemFetcher
    }
}

extension ShopAisleInteractor: ShopAisleInteractorInput {
    
    func moduleDidLoad() {
    }
}
