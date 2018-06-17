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
        self.itemFetcher.fetchItems { items, error in
            guard error == nil else {
                self.output?.errorFetchingItems(error: error!)
                return
            }
            guard let items = items else {
                self.output?.errorFetchingItems(error: ItemFetcherError.parsingError)
                return
            }
            self.output?.didReceive(items: items)
            
        }
    }
}
