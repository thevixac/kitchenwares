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
    func imageRequestedFor(item: ShopItem) {
        guard let url = URL(string: "https:" + item.imagePath) else {
            return
        }
    }
    
    
    func set(output: ShopAisleInteractorOutput) {
        self.output = output
    }
    
    func moduleDidLoad() {
        self.itemFetcher.fetchItems { items, error in
            if let error = error {
                self.output?.errorFetchingItems(error: error)
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
