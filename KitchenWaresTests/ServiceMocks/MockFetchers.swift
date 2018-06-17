//
//  MockFetchers.swift
//  KitchenWaresTests
//
//  Created by vic on 17/06/2018.
//  Copyright © 2018 vixac. All rights reserved.
//

import Foundation
@testable import KitchenWares

class MockItemFetcher: ItemFetcherProtocol {
    var itemsToReturn: [ShopItem]?
    var errorToReturn: ItemFetcherError?
    var fetchCalled = false
    func fetchItems(completion: @escaping (([ShopItem]?, ItemFetcherError?) -> Void)) {
        fetchCalled = true
        completion(itemsToReturn, errorToReturn)
    }
    
}

class MockDishwaserJsonParser: DishwasherParserProtocol {
    var itemToReturn: ShopItem?
    var errorToReturn: JsonParseError?
    func parse(item: Json) -> (item: ShopItem?, error: JsonParseError?) {
        return (itemToReturn, errorToReturn)
    }
}
