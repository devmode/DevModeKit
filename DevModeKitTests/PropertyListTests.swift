@testable import DevModeKit
import XCTest

class PropertyListTests: XCTestCase {
  
  func testString() {
    PropertyList.environment = .production
    PropertyList.bundle = Bundle(for: type(of: self))
    assert(PropertyList.main["Group.TestProperty"].string == "TestValue")
  }
}
