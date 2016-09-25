//
//  DepotTests.swift
//  DepotTests
//
//  Created by Sameh Mabrouk on 8/23/16.
//  Copyright © 2016 smapps. All rights reserved.
//

import XCTest
@testable import Depot

class DepotTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testPersistableStruct() {
        let person = Person(name: "Sameh", age: 30, id: 100)
        
        Depot.persist(person, key: "person")
        
        //        print("Persisted Struct: \(UserDefaults.standard.object(forKey: "person"))")
        //
        //       let persistedDict =  UserDefaults.standard.object(forKey: "person") as? NSDictionary
        //        print("pesisted Name: \(persistedDict?["name"])")
        //
        //        XCTAssert("Sameh" == "Sameh", "basic string was incorrect")
        
        if let retreivedPerson:Person = Depot.retreive("person") {
            XCTAssert(retreivedPerson.name == "Sameh", "person name is not correct")
            XCTAssert(retreivedPerson.age == 30, "person age is not correct")
            XCTAssert(retreivedPerson.id == 100, "person id is not correct")
        } else {
            XCTFail("no person struct retreived")
        }
    }
    
    func testPersistableNilStruct() {
        let emptyPerson = EmptyPerson(name: "Steve", age: 50, id: 1)
        
        Depot.persist(emptyPerson, key: "empty")
        
        let retreivedPerson: EmptyPerson? = Depot.retreive("empty")
        XCTAssert(retreivedPerson == nil)
    }
    
    func testPersistableStructArray() {
        let person1 = Person(name: "Sameh", age: 30, id: 100)
        let person2 = Person(name: "Steve", age: 40.3, id: 66)
        let person3 = Person(name: "Bill", age: 50, id: 77)
        
        let persons = [Person]( arrayLiteral: person1, person2, person3)
        
        Depot.persist(persons, key: "person_collection")
        
        if let retreivedPersons: [Person] = Depot.retreive("person_collection") {
            XCTAssert(retreivedPersons.count == 3, "Retreived count of structs is not correct")
            
            XCTAssert(retreivedPersons[1].name == "Steve" , "Person2 name is not correct")
            XCTAssert(retreivedPersons[1].age == 40.3 , "Person2 age is not correct")
            XCTAssert(retreivedPersons[1].id == 66 , "Person2 id is not correct")
        } else {
            XCTFail("no person struct collection retreived")
        }
    }
    
    
    
    /*
     func testExample() {
     // This is an example of a functional test case.
     // Use XCTAssert and related functions to verify your tests produce the correct results.
     }
     
     func testPerformanceExample() {
     // This is an example of a performance test case.
     self.measure {
     // Put the code you want to measure the time of here.
     }
     }
     */
}
