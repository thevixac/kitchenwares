//
//  ShopAislePresenter.swift
//  KitchenWares
//
//  Created by vic on 15/06/2018.
//  Copyright © 2018 vixac. All rights reserved.
//

import UIKit

struct ShopItemDisplayable {
    let productId: String
    let title: String
    let price: String
    let imagePath: String
}

class ShopAislePresenter {
    private let input: ShopAisleInteractorInput
    private weak var view: ShopAisleView?
    init(with input: ShopAisleInteractorInput) {
        self.input = input
    }
}

extension ShopAislePresenter: ShopAisleEventHandler {
    func itemWillAppear(item: ShopItemDisplayable) {
        input.imageRequestedFor(productId: item.productId, imagePath: item.imagePath)
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
        guard let data = data else { return }
        guard let image = UIImage(data: data) else { return }
        view?.displayImage(identifier: productId, image: image)
    }
    
    func errorFetchingItems(error: ItemFetcherError) {
        print("Error: presenter errorFetchingItems: \(error)")
    }
    
    private func display(price: Float) -> String {
        return String(format: "£%.2f", price)
    }
    func didReceive(items: [ShopItem]) {
        let displayables: [ShopItemDisplayable] = items.map { return ShopItemDisplayable(productId: $0.productId, title: $0.title, price: display(price: $0.price), imagePath: $0.imagePath)}
        view?.display(items: displayables)
    }
}
