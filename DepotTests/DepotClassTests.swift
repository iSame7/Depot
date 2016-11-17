//
//  DepotClassTests.swift
//  Depot
//
//  Created by Sameh Mabrouk on 17/11/16.
//  Copyright © 2016 smapps. All rights reserved.
//

import XCTest
@testable import Depot

class DepotClassTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    // persistable class
    func testPersistableClass() {
        let personclass = PersonClass(name: "Sameh", age: 30, id: 100)
        
        Depot.persist(personclass, key: "personclass")
        
        if let retreivedPerson:PersonClass = Depot.retreive("personclass") {
            XCTAssert(retreivedPerson.name == "Sameh", "person name is not correct")
            XCTAssert(retreivedPerson.age == 30, "person age is not correct")
            XCTAssert(retreivedPerson.id == 100, "person id is not correct")
        } else {
            XCTFail("no person class retreived")
        }
    }
    
    // persistable array of classes
    func testPersistableClassArray() {
        let person1 = PersonClass(name: "Sameh", age: 30, id: 100)
        let person2 = PersonClass(name: "Steve", age: 40.3, id: 66)
        let person3 = PersonClass(name: "Bill", age: 50, id: 77)
        
        let persons = [PersonClass]( arrayLiteral: person1, person2, person3)
        
        Depot.persist(persons, key: "personclass_collection")
        
        if let retreivedPersons: [Person] = Depot.retreive("personclass_collection") {
            XCTAssert(retreivedPersons.count == 3, "Retreived count of structs is not correct")
            
            XCTAssert(retreivedPersons[1].name == "Steve" , "Person2 name is not correct")
            XCTAssert(retreivedPersons[1].age == 40.3 , "Person2 age is not correct")
            XCTAssert(retreivedPersons[1].id == 66 , "Person2 id is not correct")
        } else {
            XCTFail("no person class collection retreived")
        }
    }
    
    // persistable parent child classes
    func testParentChildPersistableClass()  {
        let personclass = PersonClass(name: "Sameh", age: 30, id: 100)
        
        let parentChildClass = ParentwithChildClass(name: "Parent", person: personclass)
        
        Depot.persist(parentChildClass, key: "parent_child")

        if let retreivedParentwithChild:ParentwithChildClass = Depot.retreive("parent_child") {
            XCTAssert(retreivedParentwithChild.name == "Parent", "person name is not correct")
            
            if let retreivedPerson:PersonClass = retreivedParentwithChild.person {
                XCTAssert(retreivedPerson.name == "Sameh", "person name is not correct")
                XCTAssert(retreivedPerson.age == 30, "person age is not correct")
                XCTAssert(retreivedPerson.id == 100, "person id is not correct")
            } else {
                XCTFail("no person class retreived")
            }
            
        } else {
            XCTFail("no Parent with child class retreived")
        }
        
    }
    
}
