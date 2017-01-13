# DevModeKit
A series of helpful Swift extensions and utilities.

## Extensions
A series of helpful extensions.

### Date Extensions
Lots of additional `Date` functionality.

### Image Extensions
Ever wish you could more easily create a `UIImage` from a `URL` object?  Now you can!
```swift
UIImage.load("http://cdn.devmode.com/assets/ben_bio-818b58fc249a9d19ba5a5ce436dd54e1.jpg") { img in
  ...
}
```
Also, your `UIImage` will be cached locally after first use.

### URL Extensions
Easily parse a `URL` query string into a `Dictionary` of key/value pairs.
```swift
let url = URL(string: "http://www.devmode.com?param1=value1&param2=value2&param3=value3")
url?.parsedQuery["param1"] // "value1"
url?.parsedQuery["param2"] // "value2"
url?.parsedQuery["param3"] // "value3"
```

## Utilities
A series of helpful utilities.

### AsynchronousOperation
A subclass of `Operation` for asynchronous tasks.
```swift
loadingQueue = OperationQueue()
loadingQueue.maxConcurrentOperationCount = 2
loadingQueue.addOperation(AsynchronousOperation { done in
  ...
})
```
### Defaults
Easily retrieve and store persistent device-specific default values via subscript.
```swift
Defaults.standard["KEY"] = "VALUE"
Defaults.standard["KEY"] as? String // "VALUE"
```
### Logging
Ever wish you could use traditional logging mechanisms in Swift?  Now you can!
```swift
Logger.log("Test", .warning, "Hello World!")
Logger.warning("Test", "Hello World!")
```
### Property Lists
Ever wish you could interact with values from property files more easily?  Now you can!  
```swift
// Set a persistent environment to switch between property lists.
PropertyList.currentEnvironment = .Production

// Use subscripts and dot-syntax to retrieve values from property list files.
PropertyList.main["Group.Key"].string // <value-from-property-list>
```
