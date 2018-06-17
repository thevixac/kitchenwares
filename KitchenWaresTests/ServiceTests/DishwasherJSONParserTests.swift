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
        guard let item = result.item else {
            XCTFail("Missing Item.")
            return
        }
        XCTAssertEqual(item.productId, "3215462")
        XCTAssertEqual(item.imagePath, "//johnlewis.scene7.com/is/image/JohnLewis/236888507?")
        XCTAssertEqual(item.price, 349.00)
        XCTAssertEqual(item.title, "Bosch SMS25AW00G Freestanding Dishwasher, White")
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
        let exp = expectation(description: "testMissingProductId")
        if let error = result.error {
            if case JsonParseError.missingField(let field) = error {
                if field == "productId" {
                    exp.fulfill()
                }
            }
        }
        waitForExpectations(timeout: 0)
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
        let exp = expectation(description: "testMissingTitle")
        if let error = result.error {
            if case JsonParseError.missingField(let field) = error {
                if field == "title" {
                    exp.fulfill()
                }
            }
        }
        waitForExpectations(timeout: 0)
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
        let exp = expectation(description: "testMissingImage")
        if let error = result.error {
            if case JsonParseError.missingField(let field) = error {
                if field == "image" {
                    exp.fulfill()
                }
            }
        }
        waitForExpectations(timeout: 0)
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
        let exp = expectation(description: "testMissingPrice")
        if let error = result.error {
            if case JsonParseError.missingField(let field) = error {
                if field == "price" {
                    exp.fulfill()
                }
            }
        }
        waitForExpectations(timeout: 0)
    }
    
    /**
     * When: now is missing
     * Then: The parser should return missing now error
     */
    func testMissingNow() {
        let json = noNowPriceJson()
        let result = testObject.parse(item: json)
        XCTAssertNil(result.item)
        let exp = expectation(description: "testMissingNow")
        if let error = result.error {
            if case JsonParseError.missingField(let field) = error {
                if field == "now" {
                    exp.fulfill()
                }
            }
        }
        waitForExpectations(timeout: 0)
    }
    
    /**
     * When: now is not parsable into a number
     * Then: The parser should return invalid type error
     */
    func testNowIsNaN() {
        let json = invalidNowPriceJson()
        let result = testObject.parse(item: json)
        XCTAssertNil(result.item)
        let exp = expectation(description: "testNowIsNaN")
        if let error = result.error {
            if case JsonParseError.invalidType(let field) = error {
                if field == "now" {
                    exp.fulfill()
                }
            }
        }
        waitForExpectations(timeout: 0)
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
