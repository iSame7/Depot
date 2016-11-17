<p align="center">
    <img src="https://download.canva.com/DAB_Y-_pA2Q/22/custom/0001-55635799.png?response-content-disposition=attachment%3B%20filename%2A%3DUTF-8%27%27Depot.png&response-expires=Thu%2C%2013%20Oct%202016%2021%3A00%3A00%20GMT&AWSAccessKeyId=AKIAIXVXZHH2YGSHDJVQ&Expires=1476392400&Signature=gTE5yk3GFJP69IIdjkSAjnRSOtw%3D" alt="Storage" />
</p>

# Depot
Struct persistance framework for Swift. Simple as that:

```swift
let myStruct = MyStruct(...)

Depot.persist(myStruct, "cached_data")

if let retrievedStruct: MyStruct = Depot.retrieved("cached_data") {
  print("MyStruct is retrieved",unpackedCustomStruct)
} else {
  print("no struct retrieved")
}
```
## Features:

Depot can store differnet types:

* [x] Structs
* [x] Arrays of structs
* [x] Nested structs
* [x] Enums with raw types
* [x] Classes
* [x] Array of classes
* [x] Parent with childs classes

## Installation

Installation for [CocoaPods](https://cocoapods.org) by adding the following line to your Podfile:

```ruby
use_frameworks!

pod 'Depot'
```

## Usage 

### Structs

To support persisting struct, a struct needs to implement `PropertyListReadable` protocol which includes the following functions:
```swift
init?(storehouse: Storehousable)
func propertyListRepresentation() -> [String: AnyObject]
```

`init` method that gets each property from the storehouse, and a `propertyListRepresentation` method that converts structs to Sictionary that can persisted:

```swift
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
        self.name = storehouse.read(key: "name") ?? ""
        self.age = storehouse.read(key: "age") ?? 25.5
        self.id = storehouse.read(key: "id") ?? 22
    }
    
    func propertyListRepresentation() -> [String : AnyObject] {
        return [ "name": self.name, "age": self.age, "id": self.id ]
    }
}
```
## License

Depot made available under the MIT license.

## Credits

Depot is brought to you by [Sameh Mabrouk](http://isame7.github.io/)

[mabrouksameh@gmail.com][2]

[@same7mabrouk][3] 

  [2]: mailto:mabrouksameh@gmail.com
  [3]: http://twitter.com/same7mabrouk
