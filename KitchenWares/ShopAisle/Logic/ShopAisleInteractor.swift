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
    func imageRequestedFor(productId: ProductId, imagePath: String) {
        guard let url = URL(string: "https:" + imagePath) else {
            return
        }
        itemFetcher.fetchImage(url: url) { [weak self] result, error in
            guard let `self` = self else { return }
            guard error == nil else { return }
            
            self.output?.imageReceived(productId: productId, data: result)
        }
    }
    
    func set(output: ShopAisleInteractorOutput) {
        self.output = output
    }
    
    func moduleDidLoad() {
        self.itemFetcher.fetchItems { [weak self]  items, error in
            guard let `self` = self else { return }
            
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
