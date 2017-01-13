@testable import DevModeKit
import XCTest

class UrlTests: XCTestCase {
  
  func testParsedQuery() {
    let url = URL(string: "http://www.devmode.com?param1=value1&param2=value2&param3=value3")
    assert(url?.parsedQuery["param1"] == "value1")
    assert(url?.parsedQuery["param2"] == "value2")
    assert(url?.parsedQuery["param3"] == "value3")
  }
}
