//
//  DishwasherJSONParserTests.swift
//  KitchenWaresTests
//
//  Created by vic on 17/06/2018.
//  Copyright © 2018 vixac. All rights reserved.
//

import XCTest

@testable import KitchenWares

class DishwasherJSONParserTests: XCTestCase {
    
    private var testObject: DishwasherJSONParser!
    override func setUp() {
        super.setUp()
        testObject = DishwasherJSONParser()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    /**
     * When: a valid dictionary is passed in
     * Then: The parser should return a ShopItem
     */
    func testValidInput() {
        let result = testObject.parse(item: validJson())
        XCTAssertNil(result.error)
        XCTAssertNotNil(result.item)
    }
    
    /**
     * When: productId is missing
     * Then: The parser should return missing productId error
     */
    func testMissingProductId() {
        var json = validJson()
        json["productId"] = nil
        let result = testObject.parse(item: json)
        XCTAssertNil(result.item)
        guard let error = result.error else {
            XCTFail("Missing error.")
            return
        }
        if case JsonParseError.missingField(let field) = error {
            if field != "productId" {
                XCTFail("Wrong error field.")
            }
        } else {
            XCTFail("Wrong error type.")
        }
    }

    /**
     * When: title is missing
     * Then: The parser should return missing title error
     */
    func testMissingTitle() {
        var json = validJson()
        json["title"] = nil
        let result = testObject.parse(item: json)
        XCTAssertNil(result.item)
        guard let error = result.error else {
            XCTFail("Missing error.")
            return
        }
        if case JsonParseError.missingField(let field) = error {
            if field != "title" {
                XCTFail("Wrong error field.")
            }
        } else {
            XCTFail("Wrong error type.")
        }
    }
    
    /**
     * When: image is missing
     * Then: The parser should return missing image error
     */
    func testMissingImage() {
        var json = validJson()
        json["image"] = nil
        let result = testObject.parse(item: json)
        XCTAssertNil(result.item)
        guard let error = result.error else {
            XCTFail("Missing error.")
            return
        }
        if case JsonParseError.missingField(let field) = error {
            if field != "image" {
                XCTFail("Wrong error field.")
            }
        } else {
            XCTFail("Wrong error type.")
        }
    }
    /**
     * When: price is missing
     * Then: The parser should return missing now price error
     */
    func testMissingPrice () {
        var json = validJson()
        json["price"] = nil
        let result = testObject.parse(item: json)
        XCTAssertNil(result.item)
        guard let error = result.error else {
            XCTFail("Missing error.")
            return
        }
        if case JsonParseError.missingField(let field) = error {
            if field != "price" {
                XCTFail("Wrong error field.")
            }
        } else {
            XCTFail("Wrong error type.")
        }
    }
    
    /**
     * When: now is missing
     * Then: The parser should return missing now error
     */
    func testMissingNow() {
        let json = noNowPriceJson()
        let result = testObject.parse(item: json)
        XCTAssertNil(result.item)
        guard let error = result.error else {
            XCTFail("Missing error.")
            return
        }
        if case JsonParseError.missingField(let field) = error {
            if field != "now" {
                XCTFail("Wrong error field.")
            }
        } else {
            XCTFail("Wrong error type.")
        }
    }
    
    /**
     * When: now is not parsable into a number
     * Then: The parser should return invalid type error
     */
    func testNowIsNaN() {
        let json = invalidNowPriceJson()
        let result = testObject.parse(item: json)
        XCTAssertNil(result.item)
        guard let error = result.error else {
            XCTFail("Missing error.")
            return
        }
        if case JsonParseError.invalidType(let field) = error {
            if field != "now" {
                XCTFail("Wrong error field.")
            }
        } else {
            XCTFail("Wrong error type.")
        }
    }
    
    private func validJson() -> Json {
       return  ["productId": "3215462",
        "type": "product",
        "title": "Bosch SMS25AW00G Freestanding Dishwasher, White",
        "reviews": 71,
        "price": [
            "now": "349.00"
        ],
        "image": "//johnlewis.scene7.com/is/image/JohnLewis/236888507?"
        ]
    }
    
    private func noNowPriceJson() -> Json {
        return  ["productId": "3215462",
                 "type": "product",
                 "title": "Bosch SMS25AW00G Freestanding Dishwasher, White",
                 "reviews": 71,
                 "price": [
                    "missingNowPrice": "349.00"
            ],
                "image": "//johnlewis.scene7.com/is/image/JohnLewis/236888507?"
        ]
    }
    
    private func invalidNowPriceJson() -> Json {
        return  ["productId": "3215462",
                 "type": "product",
                 "title": "Bosch SMS25AW00G Freestanding Dishwasher, White",
                 "reviews": 71,
                 "price": [
                    "now": ""
            ],
                 "image": "//johnlewis.scene7.com/is/image/JohnLewis/236888507?"
        ]
    }
}
