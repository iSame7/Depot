//
//  PropertyListReadable.swift
//  Depot
//
//  Created by Sameh Mabrouk on 8/23/16.
//  Copyright © 2016 smapps. All rights reserved.
//

import Foundation

/**
 Swift Struct cann't coform to NSCoder protocol.
 Since we know that we can’t associate NSCoder with our struct, we need to figure out another way to deal with it. We use a protocol.
 Since property lists are just NSDictionary objects, we need to make sure that anything that conforms to PropertyListReadable is able to create and take in NSDictionary objects.

 - I created a playground that contains the code that describe how to persist struct. Kindly follow the URL here:
 [StructPersistorSwiftPlayground](https://github.com/iSame7/StructPersistorSwiftPlayground "StructPersistorSwiftPlayground")
 */

public protocol PropertyListReadable {

    /**
     The propertyListRepresentation function works under the assumption that a Struct instance was already able to be initialized with the correct number and types of parameters. This function goes through the Struct instance and sets key-value pairs for each of the variables and returns an NSDictionary. This function allows you to take any and all Struct instances and format them in such a way that they can be persisted to the NSUserDefaults.

     - returns: [String: AnyObject]
     */
    func propertyListRepresentation() -> [String: AnyObject]

    /**
     This methode assume you have extracted an NSDictionary from the NSUserDefaults and you want to break it back down into a Struct instance.

     - parameter NSDictionary: the dictionary to be converted back to Struct instance.
     */
    //init?(propertyListRepresentation:NSDictionary?)
    
    /**
     to initialize Struct from Storehousable object.
     
     - parameter warehouse: the `Storehousable` object from which you can extract your struct's properties
     */
    init?(storehouse: Storehousable)
}


public extension PropertyListReadable {

    /**
     The propertyListRepresentation function works under the assumption that a Struct instance was already able to be initialized with the correct number and types of parameters. This function goes through the Struct instance and sets key-value pairs for each of the variables and returns an NSDictionary. This function allows you to take any and all Struct instances and format them in such a way that they can be persisted to the NSUserDefaults.

     - returns: [String: AnyObject]
     */
    func propertyListRepresentation() -> [String: AnyObject] {
        return Mirror(reflecting: self).convertToDictionary()
    }

}

// MARK: list of supported persistable types

public protocol PropertyListReadableType{}

extension Bool: PropertyListReadableType {}
extension String: PropertyListReadableType {}
extension Int: PropertyListReadableType {}
extension Float: PropertyListReadableType {}
extension Double: PropertyListReadableType {}
extension Date: PropertyListReadableType {}














