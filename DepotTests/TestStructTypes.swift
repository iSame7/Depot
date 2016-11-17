//
//  TestStructTypes.swift
//  Depot
//
//  Created by smapps on 9/12/16.
//  Copyright © 2016 smapps. All rights reserved.
//

import Foundation
import Depot

struct Person: PropertyListReadable {
    let name: String
    let age: Float
    let id: Int
    
    init(name: String, age: Float, id: Int) {
        self.name = name
        self.age = age
        self.id = id
    }
    
    init?(storehouse: Storehousable) {
        self.name = storehouse.read("name") ?? ""
        self.age = storehouse.read("age") ?? 25.5
        self.id = storehouse.read("id") ?? 22
    }
}
struct EmptyPerson: PropertyListReadable {
    let name: String
    let age: Float
    let id: Int
    
    init(name: String, age: Float, id: Int) {
        self.name = name
        self.age = age
        self.id = id
    }
    
    init?(storehouse: Storehousable) {
        return nil
    }
}

struct ParentPerson: PropertyListReadable {
    let name: String
    let age: Float
    let id: Int
    
    init(name: String, age: Float, id: Int) {
        self.name = name
        self.age = age
        self.id = id
    }
    
    init?(storehouse: Storehousable) {
        self.name = storehouse.read("name") ?? ""
        self.age = storehouse.read("age") ?? 25.5
        self.id = storehouse.read("number") ?? 22
    }
}
