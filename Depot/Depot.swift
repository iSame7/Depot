//
//  Depot.swift
//  Depot
//
//  Created by Sameh Mabrouk on 8/25/16.
//  Copyright © 2016 smapps. All rights reserved.
//

import Foundation

public class Depot {
    
    // MARK: perist objects
    
    /**
     Persist generic struct that conform to `PropertyListReadable` protocol
     - parameter object: Object that will be persisted
     - parameter key: The object's key
     */
    public static func persist<T:PropertyListReadable>(object: T, key: String) {
        
        // 1- get the storehouse that objec can be stored in.
        let storehouse = getStorehouse(key)
        
        // 2- write the passed object to the storehouse.
        storehouse.write(object: object.propertyListRepresentation() as AnyObject)
    }
    
    /**
     Persist generic collection of structs that conform to `PropertyListReadable` protocol
     - parameter object: Object that will be persisted
     - parameter key: The object's key
     */
    public static func persist<T:PropertyListReadable>(objects: [T], key: String) {
        
        // 1- get the storehouse that objec can be stored in.
        let storehouse = getStorehouse(key)
        
        // 2- construct array of dictionaries that will be persisted
        var arryOfDics = [AnyObject]()
        for object in objects {
            arryOfDics.append(object.propertyListRepresentation() as AnyObject)
        }
        // 3- write the passed object to the storehouse.
        storehouse.write(object: arryOfDics as AnyObject)
    }
    
    // MARK: retreive objects
    
    /**
     Retreive generic struct that conform to `PropertyListReadable` protocol
     - parameter key: The object's key
     - returns: T?
     */
    public static func retreive<T:PropertyListReadable>(key: String) -> T? {
        
        // 1- get the storehouse that objec is stored in.
        let storehouse = getStorehouse(key)
        
        if storehouse.cachedDataExists() {
            // this return an initialized struct with it's all properties.
            return T(storehouse: storehouse)
        }
        
        return nil
    }
    
    /**
     Retreive generic collection of struct that conform to `PropertyListReadable` protocol
     - parameter key: The object's key
     - returns: T?
     */
    public static func retreive<T:PropertyListReadable>(key: String) -> [T]? {
        
        // 1- get the storehouse that objec is stored in.
        let storehouse = getStorehouse(key)
        
        guard storehouse.cachedDataExists(), let cachedArray = storehouse.retrieveCachedData() as? Array<AnyObject> else {
            return nil
        }
        
        var retreivedObjects = [T]()
        for case let object as Dictionary<String, AnyObject> in cachedArray {
            
            if let retrievedObject: T = retreive(dictionary: object) {
                retreivedObjects.append(retrievedObject)
            }
        }
        
        return retreivedObjects
    }
    
    /* Retreive generic struct that conform to `PropertyListReadable` protocol using passed dicionary */
    private static func retreive<T:PropertyListReadable>(dictionary: Dictionary<String, AnyObject>) -> T? {
        // 1- get the storehouse that objec is stored in.
        let storehouse = getStorehouse(dictionary as AnyObject)
        
        // this return an initialized struct with it's all properties.
        return T(storehouse: storehouse)
    }
    
    /* Get Storehouse object initialized with specific key */
    static func getStorehouse(_ key: String) -> protocol<Storehousable, StorehouseWritable> {
        return UserDefaultsStore(key: key)
    }
    
    /* Get Storehouse object initialized with generic payload */
    static func getStorehouse(_ forPayload: AnyObject) -> Storehousable {
        return UserDefaultsStore(payload: forPayload)
    }
    
    
}
