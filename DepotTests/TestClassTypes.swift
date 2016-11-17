//
//  TestClassTypes.swift
//  Depot
//
//  Created by Sameh Mabrouk on 17/11/16.
//  Copyright © 2016 smapps. All rights reserved.
//

import XCTest
import Depot

class BaseClass: PropertyListReadable {
    var name: String
    
    required init(storehouse: Storehousable) {
        self.name = storehouse.read("name") ?? ""
    }
}

class DummyStorhouse: Storehousable {
    func read<T : PropertyListReadable>(key: String) -> T? {
        return nil
    }
    func read<T : PropertyListReadableType>(key: String) -> T? {
        return nil
    }
}

class PersonClass: BaseClass {
    
    var age: Float
    var id: Int
    
    convenience init(name: String, age: Float, id: Int) {
        
        self.init(storehouse: DummyStorhouse())
        
        self.name = name
        self.age = age
        self.id = id
    }
    
    required init(storehouse: Storehousable) {
        self.age = storehouse.read("age") ?? 25.5
        self.id = storehouse.read("id") ?? 22
        
        super.init(storehouse: storehouse)

    }

}
