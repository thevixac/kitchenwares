//
//  JohnLewisURL.swift
//  KitchenWares
//
//  Created by vic on 17/06/2018.
//  Copyright © 2018 vixac. All rights reserved.
//

import Foundation

protocol URLProvider {
    func itemFetcherURL() -> URL
    func detailsURL(productID: String) -> URL
}

/**
 The simplest implementation of URLProvider using hardcoded values.
 */
class JohnLewisURL {
    func itemFetcherURL() -> URL {
        return URL(string: "https://api.johnlewis.com/v1/products/search?q=dishwasher&key=Wu1Xqn3vNrd1p7hqkvB6hEu0G9OrsYGb&pageSize=20")!
    }
    func detailsURL(productID: String) -> URL {
        return URL(string: "")!
    }
}
