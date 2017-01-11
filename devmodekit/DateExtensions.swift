import Foundation

fileprivate let DayComponents: NSCalendar.Unit = [NSCalendar.Unit.year, NSCalendar.Unit.month, NSCalendar.Unit.day]
fileprivate let TimeComponents: NSCalendar.Unit = [NSCalendar.Unit.hour, NSCalendar.Unit.minute]
fileprivate let TotalComponents = DayComponents.union(TimeComponents)

/// All ISO date formats.
fileprivate let isoFormats = [
  "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ", "yyyy-MM-dd'T'HH:mm:ss.SSSZ", "yyyy-MM-dd'T'HH:mm:ss.SSS",
  "yyyy-MM-dd'T'HH:mm:ssZZZZZ", "yyyy-MM-dd'T'HH:mm:ssZ", "yyyy-MM-dd'T'HH:mm:ss",
  "yyyy-MM-dd'T'HH:mmZZZZZ", "yyyy-MM-dd'T'HH:mmZ", "yyyy-MM-dd'T'HH:mm", "yyyy-MM-dd"
]

/// Additional date-related functionality.
public extension Date {
  public static var calendar = Calendar.current
  public static func sharedCalendar() -> Calendar {
    return calendar
  }
  
  // MARK: Date Formatting
  
  public static func fromIso8601(_ formattedDate: String) -> Date? {
    let formatter = DateFormatter()
    formatter.timeZone = Date.sharedCalendar().timeZone
    for format in isoFormats {
      formatter.dateFormat = format
      if let date = formatter.date(from: formattedDate) {
        return date
      }
    }
    return nil
  }
  
  public func toIso8601() -> String {
    let formatter = DateFormatter()
    formatter.timeZone = Date.sharedCalendar().timeZone
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
    return formatter.string(from: self)
  }
  
  public func string(_ format: String) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = format
    return formatter.string(from: self)
  }
  
  public func string(with dateStyle: DateFormatter.Style = .short, and timeStyle: DateFormatter.Style = .none) -> String {
    let formatter = DateFormatter()
    formatter.dateStyle = dateStyle
    formatter.timeStyle = timeStyle
    return formatter.string(from: self)
  }
  
  // MARK: Helper Methods
  
  public static var today: Date {
    let components = (sharedCalendar() as NSCalendar).components(DayComponents, from: Date())
    guard let result = sharedCalendar().date(from: components) else { return Date() }
    return result
  }
  
  public func isToday() -> Bool {
    let components = (Date.sharedCalendar() as NSCalendar).components(DayComponents, from: self)
    guard let result = Date.sharedCalendar().date(from: components) else { return false }
    return (result == Date.today)
  }
  
  public func isWeekend() -> Bool {
    let weekday = (Date.sharedCalendar() as NSCalendar).component(NSCalendar.Unit.weekday, from: self)
    return weekday == 1 || weekday == 7
  }
  
  // MARK: Modify Date
  
  public func nextDay() -> Date {
    return self.addDays(1)
  }
  
  public func previousDay() -> Date {
    return self.addDays(-1)
  }
  
  public func addDays(_ days : Int) -> Date {
    var components = (Date.sharedCalendar() as NSCalendar).components(DayComponents, from: self)
    components.day = components.day! + days
    guard let result = Date.sharedCalendar().date(from: components) else { return Date() }
    return result
  }
  
  public func addBusinessDays(_ days : Int) -> Date {
    var idx = 0
    var current = self
    while idx < days {
      current = current.addDays(1)
      if !current.isWeekend() {
        idx += 1
      }
    }
    return current
  }
  
  public func addWeeks(_ weeks : Int) -> Date {
    return addDays(weeks*7)
  }
  
  public func addMonths(_ months : Int) -> Date {
    var components = (Date.sharedCalendar() as NSCalendar).components([.year, .month], from: self)
    components.month = components.month! + months
    guard let result = Date.sharedCalendar().date(from: components) else { return Date() }
    return result
  }
  
  public func addYears(_ years : Int) -> Date {
    return addMonths(years*12)
  }
  
  public func addHours(_ hours : Int) -> Date {
    var components = (Date.sharedCalendar() as NSCalendar).components(TotalComponents, from: self)
    components.hour = components.hour! + hours
    guard let result = Date.sharedCalendar().date(from: components) else { return Date() }
    return result
  }
  
  public func addMinutes(_ minutes : Int) -> Date {
    var components = (Date.sharedCalendar() as NSCalendar).components(TotalComponents, from: self)
    components.minute = minutes
    guard let result = Date.sharedCalendar().date(from: components) else { return Date() }
    return result
  }
  
  public func roundUpMinutes(_ nearestMinutes:Int) -> Date {
    var components = (Date.sharedCalendar() as NSCalendar).components(TotalComponents, from: self)
    components.minute = ((components.minute! + nearestMinutes)/nearestMinutes)*nearestMinutes
    components.second = 0
    guard let result = Date.sharedCalendar().date(from: components) else { return Date() }
    return result
  }
  
  // MARK: Date Conversion
  
  public var minutesIntoDay: Int {
    let components = (Date.sharedCalendar() as NSCalendar).components(TotalComponents, from: self)
    return components.hour! * 60 + components.minute!
  }
  
  public var startOfHour: Date {
    var components = (Date.sharedCalendar() as NSCalendar).components(TotalComponents, from: self)
    components.minute = 0
    guard let result = Date.sharedCalendar().date(from: components) else { return Date() }
    return result
  }
  
  public var startOfDay: Date {
    var components = (Date.sharedCalendar() as NSCalendar).components(DayComponents.union(NSCalendar.Unit.hour), from: self)
    components.hour = 1
    guard let result = Date.sharedCalendar().date(from: components) else { return Date() }
    return result
  }
  
  public var startOfMonth: Date {
    var components = (Date.sharedCalendar() as NSCalendar).components(DayComponents, from: self)
    components.day = 1
    guard let result = Date.sharedCalendar().date(from: components) else { return Date() }
    return result
  }
  
  public var endOfMonth: Date {
    var components = (Date.sharedCalendar() as NSCalendar).components(DayComponents, from: self)
    components.month = components.month! + 1
    components.day = 0
    guard let result = Date.sharedCalendar().date(from: components) else { return Date() }
    return result
  }
  
  public var hour: Int {
    let components = (Date.sharedCalendar() as NSCalendar).components(DayComponents.union(.hour), from: self)
    return components.hour!
  }
  
  public var day: Int {
    let components = (Date.sharedCalendar() as NSCalendar).components(DayComponents, from: self)
    return components.day!
  }
  
  public func toMidnightGMT() -> Date {
    let gmt = TimeZone(identifier: "GMT")
    let formatter = DateFormatter()
    formatter.timeZone = gmt
    formatter.dateFormat = "yyyy-MM-dd"
    let dateString = formatter.string(from: self)
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
    guard let result = formatter.date(from: "\(dateString)T0:00") else { return Date() }
    return result
  }
}
