//
//  DishwasherJSONParser.swift
//  KitchenWares
//
//  Created by vic on 17/06/2018.
//  Copyright © 2018 vixac. All rights reserved.
//

import Foundation

enum JsonParseError {
    case missingField(String)
    case invalidType(String)
}

typealias Json = [String: Any]
class DishwasherJSONParser {
    
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
