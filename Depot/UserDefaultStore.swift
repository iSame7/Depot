//
//  UserDefaultStore.swift
//  Depot
//
//  Created by smapps on 9/10/16.
//  Copyright © 2016 smapps. All rights reserved.
//

import Foundation

/**
 NSUserDefaultsStore allows for easy state persistence and acts as a thin wrapper around NSUserDefaults.
 */


public class UserDefaultsStore: Storehousable, StorehouseWritable {

    var storeKey: String
    var payload: AnyObject?
    
    let defaults = UserDefaults.standard
    
    public init(key: String) {
        self.storeKey = key
    }
    
    public init(payload: AnyObject) {
        self.storeKey = ""
        self.payload = payload
    }
    
    /**
     Retrieve generic object adopting `PropertyListReadable` protocol for a given key from store
     - parameter key: The item's key
     - returns: T?
     */
    public func read<T : PropertyListReadable>(key: String) -> T? {
        
        guard let storedObject = self.defaults.object(forKey: key) else {
            return nil
        }
        // the store that contains the struct.
        let storehouse = UserDefaultsStore(payload: storedObject as AnyObject)
        // this return an initialized struct with it's all properties.
        return T(storehouse: storehouse)
    }
    
    /**
     Retrieve generic object adopting `PropertyListReadable` protocol for a given key from store
     - parameter key: The item's key
     - returns: T?
     */
    public func read<T : PropertyListReadableType>(key: String) -> T? {
//                print("Persisted Struct: \(self.defaults.object(forKey: "person"))")
//        
//               let persistedDict =  self.defaults.object(forKey: "person") as? NSDictionary
//        
//                print("pesisted Name: \(persistedDict?["name"])")
//        
//                let storedObject1 = self.defaults.object(forKey: key) as? T
//                print("storeObject1: \(storedObject1)")
        
        guard let storedDictionary = retrieveCachedData(),  let storedObject = storedDictionary[key] as? T else {
            return nil
        }
        return storedObject
    }
    
    // MARK: StorehouseWritable methods implementation.
    
    /**
     Accept an object and store it.
     - parameter key: The object to be stored
     */
    func write(object: AnyObject) {
        self.defaults.set(object, forKey: self.storeKey)
    }
    
    /**
     Check if there is cached data or not
     - returns: Bool
     */
    func cachedDataExists() -> Bool {
        if (self.defaults.object(forKey: self.storeKey) != nil) {
            return true
        }
        
        return false
    }
    
    /**
     Load persisted data from stored if it exists.
     - returns: AnyObject?
     */
    func retrieveCachedData() -> AnyObject? {
        guard payload == nil else {
            return payload
        }
        
        guard let cachedDictionary = self.defaults.object(forKey: self.storeKey) else {
                return nil
        }
        
        return cachedDictionary as AnyObject
        
//        if let cachedDictionary = self.defaults.object(forKey: self.storeKey) as? AnyObject {
//            return cachedDictionary
//        }
//        
//        return nil
    }
}
