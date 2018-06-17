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
        //VXTODO got to parse Json
        return (nil, nil)
    }
    
}
