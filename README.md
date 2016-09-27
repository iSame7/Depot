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
