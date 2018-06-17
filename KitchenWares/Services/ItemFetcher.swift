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
}

//VXTODO put somewhere better
/*
 */
public protocol URLSession {
    func dataTask(with url: URL,
                  completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension Foundation.URLSession: URLSession {
    
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
        let task = session.dataTask(with: self.endpoint) { data, response, error in
            
        }
        task.resume()
    }
}
