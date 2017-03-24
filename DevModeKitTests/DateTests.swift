@testable import DevModeKit
import XCTest

class DateTests: XCTestCase {
  
  private var testDate = Date()
  private var testTime = Date()
  
  override func setUp() {
    super.setUp()
    Date.calendar.timeZone = TimeZone(identifier: "GMT")!
    testDate = Date.create(from: "3/25/17", with: .short, and: .none)!
    testTime = Date.create(from: "3:30 AM", with: .none, and: .short)!
  }
  
  func testMinute() {
    assert(testTime.minute == 30)
  }
  
  func testHour() {
    assert(testTime.hour == 3)
  }
  
  func testDay() {
    assert(testDate.day == 25)
  }
  
  func testMinutesIntoDay() {
    assert(testTime.minutesIntoDay == 210)
  }
  
  func testStartOfHour() {
    assert(testTime.startOfHour.minute == 0)
  }
  
  func testStartOfDay() {
    assert(testTime.startOfDay.hour == 1)
  }
  
  func testMidnightGMT() {
    assert(testTime.midnightGMT.hour == 0)
  }
  
  func testStartOfMonth() {
    assert(testDate.startOfMonth.day == 1)
  }
  
  func testEndOfMonth() {
    assert(testDate.endOfMonth.day == 31)
  }
  
  func testIsToday() {
    assert(!testDate.isToday)
  }
  
  func testIsWeekend() {
    assert(testDate.isWeekend)
    assert(!testDate.addDays(-1).isWeekend)
  }
  
  func testIso8601() {
    assert(testDate.iso8601 == "2017-03-25T00:00:00.000Z")
  }
  
  func testFromIso8601() {
    assert(testDate == Date.fromIso8601("2017-03-25T00:00:00.000Z"))
  }
  
  func testAddMinutes() {
    assert(testTime.addMinutes(45).minute == 15)
    assert(testTime.addMinutes(-45).minute == 45)
  }
  
  func testRoundUpMinutes() {
    assert(testTime.addMinutes(2).roundUpMinutes(10).minute == 40)
    assert(testTime.addMinutes(-2).roundUpMinutes(30).minute == 30)
    assert(testTime.addMinutes(2).roundUpMinutes(30).minute == 0)
  }
  
  func testAddHours() {
    assert(testTime.addHours(2).hour == 5)
    assert(testTime.addHours(-5).hour == 22)
  }
  
  func testNextDay() {
    assert(testDate.nextDay().day == 26)
  }
  
  func testPreviousDay() {
    assert(testDate.previousDay().day == 24)
  }
  
  func testAddDays() {
    assert(testDate.addDays(10).day == 4)
    assert(testDate.addDays(-30).day == 23)
  }
  
  func testAddBusinessDays() {
    assert(testDate.addDays(-1).addBusinessDays(1) == testDate.addDays(2))
  }
  
  func testAddWeeks() {
    assert(testDate.addWeeks(1) == testDate.addDays(7))
  }
  
  func testAddMonths() {
    assert(testDate.addMonths(1) == Date.sharedCalendar.date(byAdding: .month, value: 1, to: testDate)?.startOfMonth)
  }
  
  func testAddYears() {
    assert(testDate.addYears(1).string("yyyy") == "2018")
  }
  
  func testString() {
    assert(testDate.string() == "3/25/17")
    assert(testTime.string(with: .none, and: .short) == "3:30 AM")
  }
  
  func testStringWithCustomFormat() {
    assert(testDate.string("yyyy") == "2017")
    assert(testDate.string("M") == "3")
    assert(testDate.string("d") == "25")
    assert(testTime.string("h") == "3")
    assert(testTime.string("m") == "30")
  }
  
  func testCreate() {
    assert(Date.create(from: "1/1/1970", with: .short, and: .none) == Date(timeIntervalSince1970: 0))
  }
}
