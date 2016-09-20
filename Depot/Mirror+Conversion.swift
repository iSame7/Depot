//
//  Mirror+Conversion.swift
//  Depot
//
//  Created by Sameh Mabrouk on 8/25/16.
//  Copyright © 2016 smapps. All rights reserved.
//

import Foundation


extension Mirror {
    /**
     Dictionary representation
     Returns the dictioanry representation of the current `Mirror`

     - returns: [String: AnyObject]
     */
    func convertToDictionary() -> [String: AnyObject] {
        let output = self.children.reduce([:]) { (result: [String: AnyObject], child) in
            guard let key = child.label else { return result }
            var actualValue = child.value
            var childMirror = Mirror(reflecting: child.value)
            if let style = childMirror.displayStyle where style == .Optional && childMirror.children.count > 0 {
                // unwrap Optional type first
                actualValue = childMirror.children.first!.value
                childMirror = Mirror(reflecting: childMirror.children.first!.value)
            }

            if let style = childMirror.displayStyle where style == .Collection {
                // collections need to be unwrapped,
                // toDictionary called on each children
                let converted: [AnyObject] = childMirror.children
                    .filter { $0.value is PropertyListReadable || $0.value is AnyObject }
                    .map { collectionChild in
                        if let convertable = collectionChild.value as? PropertyListReadable {
                            return convertable.propertyListRepresentation() as AnyObject
                        } else {
                            return collectionChild.value as! AnyObject
                        }
                }
                return combine(result, addition: [key: converted as AnyObject])

            } else {
                // non-collection types, toDictionary or just cast default types
                if let value = actualValue as? PropertyListReadable {
                    return combine(result, addition: [key: value.propertyListRepresentation() as AnyObject])
                } else if let value = actualValue as? AnyObject {
                    return combine(result, addition: [key: value])
                } else {
                    // throw an error? not a type we support
                }
            }

            return result
        }

        // specific for class types.
        /* 
         If the subject is not a class, this will be an empty Optional. 
         If this is a class-based type, you'll get a new Mirror.
         */
        if let superClassMirror = self.superclassMirror() {
            return combine(output, addition: superClassMirror.convertToDictionary())
        }
        return output
    }

    /**
     Combine dictionaries.
     At the end we need Dictionary to be persisted so this method combine all properties of any type like class or Struct
     It's output is dictionary that combine the type's properties as a dictionary and sub dictionaries/childerns.

     - returns: [String: AnyObject]
     */
    private func combine(from: [String: AnyObject], addition: [String: AnyObject]) -> [String: AnyObject] {
        var result = [String: AnyObject]()
        [from, addition].forEach { dict in
            dict.forEach { result[$0.0] = $0.1 }
        }
        return result
    }
}
