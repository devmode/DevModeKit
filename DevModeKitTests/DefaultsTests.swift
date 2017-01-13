@testable import DevModeKit
import XCTest

class DefaultsTests: XCTestCase {
  
  func testBoolean() {
    let testKey = "TestBoolean"
    Defaults.standard.setBoolFor(testKey, value: true)
    assert(Defaults.standard.booleanFor(testKey))
  }
  
  func testSubscript() {
    let testKey = "TestSubcript"
    let testValue = "TestValue"
    Defaults.standard[testKey] = testValue as AnyObject?
    assert(Defaults.standard[testKey] as? String == testValue)
  }
}
