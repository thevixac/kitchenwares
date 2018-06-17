//
//  ItemFetcher.swift
//  KitchenWares
//
//  Created by vic on 17/06/2018.
//  Copyright © 2018 vixac. All rights reserved.
//

import Foundation

enum ItemFetcherError: Error {
    case networkError
    case parsingError
    case noData
}

protocol ItemFetcherProtocol: class {
    func fetchItems(completion: @escaping (([ShopItem]?, ItemFetcherError?) -> Void))
}

class ItemFetcher: ItemFetcherProtocol {
    
    private let endpoint: URL
    init(endpoint: URL) {
        self.endpoint = endpoint
    }
    
    func fetchItems(completion: @escaping (([ShopItem]?, ItemFetcherError?) -> Void)) {
        let task = URLSession.shared.dataTask(with: self.endpoint) {data, response, error in
            //VXTODO got to handle response.
        }
        task.resume()
    }
}
