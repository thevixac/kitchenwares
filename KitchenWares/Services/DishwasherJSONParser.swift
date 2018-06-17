//
//  DishwasherJSONParser.swift
//  KitchenWares
//
//  Created by vic on 17/06/2018.
//  Copyright © 2018 vixac. All rights reserved.
//

import Foundation

typealias Json = [String: Any]
enum JsonParseError {
    case missingField(String)
    case invalidType(String)
}

protocol DishwasherParserProtocol {
    func parse(item: Json) -> (item: ShopItem?, error: JsonParseError?)
}

class DishwasherJSONParser: DishwasherParserProtocol {
    
    private enum Fields: String {
        case productId
        case price
        case now
        case title
        case image
    }
    
    func parse(item: Json) -> (item: ShopItem?, error: JsonParseError?) {
        var field = Fields.productId.rawValue
        guard let productId = item[field] as? String else {
            return (nil, .missingField(field))
        }
        field = Fields.price.rawValue
        guard let priceJson = item[field] as? Json else {
            return (nil, .missingField(field))
        }
        field = Fields.now.rawValue
        guard let nowPrice = priceJson[field] as? String else {
            return (nil, .missingField(field))
        }
        guard let nowFloat = Float(nowPrice) else {
            return (nil, .invalidType(field))
        }

        field = Fields.title.rawValue
        guard let title = item[field] as? String else {
            return (nil, .missingField(field))
        }
        field = Fields.image.rawValue
        guard let imagePath = item[field] as? String else {
            return (nil, .missingField(field))
        }
        return (ShopItem(productId: productId, title: title, price: nowFloat, imagePath: imagePath), nil)
    }
    
}
