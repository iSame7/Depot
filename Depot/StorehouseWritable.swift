//
//  StorehouseWritable.swift
//  Depot
//
//  Created by smapps on 9/10/16.
//  Copyright © 2016 smapps. All rights reserved.
//

import Foundation

/**
 Protocol that contain writing methods, every Store must conform to this protocol to provide the writing/persistance behaviour. 
 */
protocol StorehouseWritable {
    /**
     Accept an object(NSDictionary) and store it.
     - parameter key: The object to be stored
     */
    func write(_ object: AnyObject)
 
    /**
     Load persisted data from stored if it exists.
     - returns: AnyObject?
     */
    func retrieveCachedData() -> AnyObject?
    
    /**
     Check if there is cached data or not
     - returns: Bool
     */
    func cachedDataExists() -> Bool
}
