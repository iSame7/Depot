//
//  Storehousable.swift
//  Depot
//
//  Created by smapps on 9/9/16.
//  Copyright © 2016 smapps. All rights reserved.
//

import Foundation

public protocol Storehousable: class {
    
    /**
     Retrieve generic object adopting `PropertyListReadable` protocol for a given key
     - parameter key: The item's key
     - returns: T?
     */
    func read<T: PropertyListReadable>(key: String) -> T?
    
    /**
     Retrieve `PropertyListReadableType` for a given key
     - parameter key: The item's key
     - returns: T?
     */
    func read<T: PropertyListReadableType>(key: String) -> T?
}
