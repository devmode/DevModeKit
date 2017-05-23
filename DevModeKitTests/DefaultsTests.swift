@testable import DevModeKit
import XCTest

class DefaultsTests: XCTestCase {
  
  func testBoolean() {
    let testKey = "boolKey"
    Defaults.standard[testKey] = true
    XCTAssertNotNil(Defaults.standard[testKey])
    XCTAssert(Defaults.standard[testKey])
    
    Defaults.standard[testKey] = false
    XCTAssertNotNil(Defaults.standard[testKey])
    XCTAssert(!Defaults.standard[testKey])
  }
  
  func testString() {
    let testKey = "stringKey"
    let testValue = "TestValue"
    Defaults.standard[testKey] = testValue
    XCTAssertNotNil(Defaults.standard[testKey])
    XCTAssertEqual(testValue, Defaults.standard[testKey]!)
    
    Defaults.standard[testKey] = (nil as String?)
    XCTAssertNil(Defaults.standard[testKey])
  }
  
  func testInt() {
    let testKey = "intKey"
    let testValue = 99
    Defaults.standard[testKey] = testValue
    XCTAssertNotNil(Defaults.standard[testKey])
    XCTAssertEqual(testValue, Defaults.standard[testKey])
    
    Defaults.standard[testKey] = (nil as Int?)
    XCTAssertEqual(0, Defaults.standard[testKey])
  }
  
  func testDobule() {
    let testKey = "doubleKey"
    let testValue = 99.0
    Defaults.standard[testKey] = testValue
    XCTAssertNotNil(Defaults.standard[testKey])
    XCTAssertEqual(testValue, Defaults.standard[testKey])
    
    Defaults.standard[testKey] = (nil as Double?)
    XCTAssertEqual(0.0, Defaults.standard[testKey])
  }
  
  func testData() {
    let testKey = "dataKey"
    let testValue = "TestValue".data(using: .utf8)
    Defaults.standard[testKey] = testValue
    XCTAssertNotNil(Defaults.standard[testKey])
    XCTAssertEqual(testValue, Defaults.standard[testKey]!)
    
    Defaults.standard[testKey] = (nil as Data?)
    XCTAssertNil(Defaults.standard[testKey])
  }
  
  func testStoreLoad() {
    let testKey = "storeKey"
    let testValue = TestObject()
    Defaults.standard.store(key: testKey, object: testValue)
    let loaded: TestObject? = Defaults.standard.load(key: testKey)
    XCTAssertNotNil(loaded)
    XCTAssertEqual(testValue.string, loaded!.string)
    XCTAssertEqual(testValue.int, loaded!.int)
    
    let nextLoad: TestObject? = Defaults.standard.load(key: "SomeOtherKey")
    XCTAssertNil(nextLoad)
  }
}

class TestObject: NSObject, NSCoding {
  let string: String
  let int: Int
  
  override init() {
    self.string = "String Value"
    self.int = 99
  }
  
  required init?(coder: NSCoder) {
    self.string = coder.decodeObject() as? String ?? ""
    self.int = coder.decodeObject() as? Int ?? 0
  }
  
  func encode(with coder: NSCoder) {
    coder.encode(string)
    coder.encode(int)
  }
  
}
