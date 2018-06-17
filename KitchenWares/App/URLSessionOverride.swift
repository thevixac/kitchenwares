//
//  URLSessionOverride.swift
//  KitchenWares
//
//  Created by vic on 17/06/2018.
//  Copyright © 2018 vixac. All rights reserved.
//

import Foundation


//Configure URLSession so we can it pass around as a protocol
public protocol URLSession {
    func dataTask(with url: URL,
                  completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension Foundation.URLSession: URLSession {
}
