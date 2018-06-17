//
//  FoundationMocks.swift
//  KitchenWaresTests
//
//  Created by vic on 17/06/2018.
//  Copyright © 2018 vixac. All rights reserved.
//

import Foundation

@testable import KitchenWares

fileprivate typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
class MockURLSession: KitchenWares.URLSession {
    var dataToReturn: Data?
    var responseToReturn: URLResponse?
    var errorToReturn: Error?
    func dataTask(with url: URL,
                  completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return MockURLSessionDataTask(dataToReturn: dataToReturn,
                                      responseToReturn: responseToReturn,
                                      errorToReturn: errorToReturn,
                                      completion: completionHandler)
    }
}

private class MockURLSessionDataTask: URLSessionDataTask {
    var dataToReturn: Data?
    var responseToReturn: URLResponse?
    var errorToReturn: Error?
    var completionHandler: CompletionHandler?
    init(dataToReturn: Data?, responseToReturn: URLResponse?, errorToReturn: Error?, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        self.dataToReturn = dataToReturn
        self.responseToReturn = responseToReturn
        self.errorToReturn = errorToReturn
        self.completionHandler = completion
    }
    
    
    override func resume() {
        print("VX: resuming")
        completionHandler?(dataToReturn, responseToReturn, errorToReturn)
    }
}
