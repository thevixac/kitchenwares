//
//  FoundationExtensions.swift
//  KitchenWares
//
//  Created by vic on 17/06/2018.
//  Copyright © 2018 vixac. All rights reserved.
//

import UIKit

/*
 Configure URLSession so we can it pass around as a protocol and mock it
 */
public protocol URLSession {
    func dataTask(with url: URL,
                  completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension Foundation.URLSession: URLSession {
}

extension UIViewController {
    
    var isPad: Bool {
        let horizontal = self.traitCollection.horizontalSizeClass
        let vertical = self.traitCollection.verticalSizeClass
        
        if horizontal == .unspecified && vertical == .unspecified {
            return UI_USER_INTERFACE_IDIOM() == .pad
        }
        return horizontal == .regular && vertical == .regular
    }
}
