//
//  ItemFetcher.swift
//  KitchenWares
//
//  Created by vic on 17/06/2018.
//  Copyright © 2018 vixac. All rights reserved.
//

import Foundation

enum ItemFetcherError: Error {
    case network(Error)
    case parsingError
    case noData
}

protocol ItemFetcherProtocol: class {
    func fetchItems(completion: @escaping (([ShopItem]?, ItemFetcherError?) -> Void))
    func fetchImage(url: URL, completion: @escaping((Data?, ItemFetcherError?) -> Void))
}

class ItemFetcher: ItemFetcherProtocol {
    
    private let endpoint: URL
    private let parser: DishwasherParserProtocol
    private let session: URLSession
    init(endpoint: URL, parser: DishwasherParserProtocol, session: URLSession) {
        self.endpoint = endpoint
        self.parser = parser
        self.session = session
    }
    
    func fetchItems(completion: @escaping (([ShopItem]?, ItemFetcherError?) -> Void)) {
        let task = session.dataTask(with: self.endpoint) { data, _, error in
            if let error = error {
                completion(nil, ItemFetcherError.network(error))
                return
            }
            guard let data = data else {
                completion(nil, ItemFetcherError.noData)
                return
            }
            guard let parsedData = try? JSONSerialization.jsonObject(with: data) else {
                completion(nil, ItemFetcherError.parsingError)
                return
            }
            guard let parsedJson = parsedData as? [String: Any] else {
                completion(nil, ItemFetcherError.parsingError)
                return
            }
            guard let products = parsedJson["products"] as? [Json] else {
                completion(nil, ItemFetcherError.parsingError)
                return
            }
            let shopItems: [ShopItem] = products.compactMap {
                return self.parser.parse(item: $0).item
            }
            completion(shopItems, nil)
            
        }
        task.resume()
    }
    
    func fetchImage(url: URL, completion: @escaping((Data?, ItemFetcherError?) -> Void)) {
        
    }
}
