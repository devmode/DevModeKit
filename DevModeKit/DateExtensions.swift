import Foundation

fileprivate let DayComponents: NSCalendar.Unit = [NSCalendar.Unit.year, NSCalendar.Unit.month, NSCalendar.Unit.day]
fileprivate let TimeComponents: NSCalendar.Unit = [NSCalendar.Unit.hour, NSCalendar.Unit.minute]
fileprivate let TotalComponents = DayComponents.union(TimeComponents)

fileprivate let isoFormats = [
  "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ", "yyyy-MM-dd'T'HH:mm:ss.SSSZ", "yyyy-MM-dd'T'HH:mm:ss.SSS",
  "yyyy-MM-dd'T'HH:mm:ssZZZZZ", "yyyy-MM-dd'T'HH:mm:ssZ", "yyyy-MM-dd'T'HH:mm:ss",
  "yyyy-MM-dd'T'HH:mmZZZZZ", "yyyy-MM-dd'T'HH:mmZ", "yyyy-MM-dd'T'HH:mm", "yyyy-MM-dd"
]

/// Additional date-related functionality.
public extension Date {
  
  /// The current calendar to use to determine date/time.
  /// Set the time zone on this calendar and it will persist across other Date functions.
  public static var calendar = Calendar.current
  
  /// A computed read-only instance of the current calendar.
  public static var sharedCalendar: Calendar {
    return calendar
  }
  
  /// Today's date relative to the shared calendar.
  public static var today: Date {
    let components = (sharedCalendar as NSCalendar).components(DayComponents, from: Date())
    guard let result = sharedCalendar.date(from: components) else { return Date() }
    return result
  }
  
  /// The hour relative to the shared calendar.
  public var hour: Int {
    return (Date.sharedCalendar as NSCalendar).components(DayComponents.union(.hour), from: self).hour!
  }
  
  /// The day relative to the shared calendar.
  public var day: Int {
    return (Date.sharedCalendar as NSCalendar).components(DayComponents, from: self).day!
  }
  
  /// The cumulative number of minutes into the day.
  public var minutesIntoDay: Int {
    let components = (Date.sharedCalendar as NSCalendar).components(TotalComponents, from: self)
    return components.hour! * 60 + components.minute!
  }
  
  /// The top of the hour relative to the shared calendar.
  public var startOfHour: Date {
    var components = (Date.sharedCalendar as NSCalendar).components(TotalComponents, from: self)
    components.minute = 0
    guard let result = Date.sharedCalendar.date(from: components) else { return Date() }
    return result
  }
  
  /// The start of the day relative to the shared calendar.
  public var startOfDay: Date {
    var components = (Date.sharedCalendar as NSCalendar).components(DayComponents.union(NSCalendar.Unit.hour), from: self)
    components.hour = 1
    guard let result = Date.sharedCalendar.date(from: components) else { return Date() }
    return result
  }
  
  /// Midnight GMT relative to the shared calendar.
  public var midnightGMT: Date {
    let gmt = TimeZone(identifier: "GMT")
    let formatter = DateFormatter()
    formatter.timeZone = gmt
    formatter.dateFormat = "yyyy-MM-dd"
    let dateString = formatter.string(from: self)
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
    guard let result = formatter.date(from: "\(dateString)T0:00") else { return Date() }
    return result
  }
  
  /// The first day of the month.
  public var startOfMonth: Date {
    var components = (Date.sharedCalendar as NSCalendar).components(DayComponents, from: self)
    components.day = 1
    guard let result = Date.sharedCalendar.date(from: components) else { return Date() }
    return result
  }
  
  /// The last day of the month.
  public var endOfMonth: Date {
    var components = (Date.sharedCalendar as NSCalendar).components(DayComponents, from: self)
    components.month = components.month! + 1
    components.day = 0
    guard let result = Date.sharedCalendar.date(from: components) else { return Date() }
    return result
  }
  
  /// True if the Date is the same day as today.
  public var isToday: Bool {
    let components = (Date.sharedCalendar as NSCalendar).components(DayComponents, from: self)
    guard let result = Date.sharedCalendar.date(from: components) else { return false }
    return (result == Date.today)
  }
  
  /// True if the Date is on a weekend.
  public var isWeekend: Bool {
    let weekday = (Date.sharedCalendar as NSCalendar).component(NSCalendar.Unit.weekday, from: self)
    return weekday == 1 || weekday == 7
  }
  
  /// An ISO 8601 formatted date String.
  public var iso8601: String {
    let formatter = DateFormatter()
    formatter.timeZone = Date.sharedCalendar.timeZone
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
    return formatter.string(from: self)
  }
  
  /// Converts an ISO 8601 formatted date String to a Date object.
  /// - parameter formattedDate: The ISO 8601 formatted date.
  /// - returns: The Date object.
  public static func fromIso8601(_ formattedDate: String) -> Date? {
    let formatter = DateFormatter()
    formatter.timeZone = Date.sharedCalendar.timeZone
    for format in isoFormats {
      formatter.dateFormat = format
      if let date = formatter.date(from: formattedDate) {
        return date
      }
    }
    return nil
  }
  
  // MARK: Date Modifiers
  
  /// Add minutes to the date.
  /// - parameter minute: The number of minutes to add.
  /// - returns: The date with the added minutes.
  public func addMinutes(_ minutes: Int) -> Date {
    var components = (Date.sharedCalendar as NSCalendar).components(TotalComponents, from: self)
    components.minute = minutes
    guard let result = Date.sharedCalendar.date(from: components) else { return Date() }
    return result
  }
  
  /// Rounds up the date to the nearest increment of minutes.
  /// - parameter nearestMinutes: The increment of minutes to round up to.
  /// - returns: The rounded up Date.
  public func roundUpMinutes(_ nearestMinutes: Int) -> Date {
    var components = (Date.sharedCalendar as NSCalendar).components(TotalComponents, from: self)
    components.minute = ((components.minute! + nearestMinutes) / nearestMinutes) * nearestMinutes
    components.second = 0
    guard let result = Date.sharedCalendar.date(from: components) else { return Date() }
    return result
  }
  
  /// Add hours to the date.
  /// - parameter hours: The number of hours to add.
  /// - returns: The date with the added hours.
  public func addHours(_ hours: Int) -> Date {
    var components = (Date.sharedCalendar as NSCalendar).components(TotalComponents, from: self)
    components.hour = components.hour! + hours
    guard let result = Date.sharedCalendar.date(from: components) else { return Date() }
    return result
  }
  
  /// The next day following the date.
  /// - returns: The next day following the date.
  public func nextDay() -> Date {
    return self.addDays(1)
  }
  
  /// The day immediately preceeding the date.
  /// - returns: The day immediately preceeding the date.
  public func previousDay() -> Date {
    return self.addDays(-1)
  }
  
  /// Add days to the date.
  /// - parameter days: The number of days to add.
  /// - returns: The date with added days.
  public func addDays(_ days: Int) -> Date {
    var components = (Date.sharedCalendar as NSCalendar).components(DayComponents, from: self)
    components.day = components.day! + days
    guard let result = Date.sharedCalendar.date(from: components) else { return Date() }
    return result
  }
  
  /// Add business days to the date.
  /// - parameter days: The number of business days to add.
  /// - returns: The date with the added business days.
  public func addBusinessDays(_ days: Int) -> Date {
    var idx = 0
    var current = self
    while idx < days {
      current = current.addDays(1)
      if !current.isWeekend {
        idx += 1
      }
    }
    return current
  }
  
  /// Add weeks to the date.
  /// - parameter weeks: The number of weeks to add.
  /// - returns: The date with the added weeks.
  public func addWeeks(_ weeks: Int) -> Date {
    return addDays(weeks*7)
  }
  
  /// Add months to the date.
  /// - parameter months: The number of months to add.
  /// - returns: The date with the months added.
  public func addMonths(_ months: Int) -> Date {
    var components = (Date.sharedCalendar as NSCalendar).components([.year, .month], from: self)
    components.month = components.month! + months
    guard let result = Date.sharedCalendar.date(from: components) else { return Date() }
    return result
  }
  
  /// Add years to the date.
  /// - parameter years: The number of years to add.
  /// - returns: The date with the years added.
  public func addYears(_ years: Int) -> Date {
    return addMonths(years * 12)
  }
  
  // MARK: Date Formatters
  
  /// A quick way to convert a Date to a String using a known style.
  /// - parameter dateStyle: The known style of the date.
  /// - parameter timeStyle: The known style of the time.
  /// - returns: The styled Date as a String.
  public func string(with dateStyle: DateFormatter.Style = .short, and timeStyle: DateFormatter.Style = .none) -> String {
    let formatter = DateFormatter()
    formatter.dateStyle = dateStyle
    formatter.timeStyle = timeStyle
    return formatter.string(from: self)
  }
  
  /// A quick way to convert a Date to a String with a custom format.
  /// - parameter format: The custom format of the Date as a String.
  /// - returns: The formatted Date as a String.
  public func string(_ format: String) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = format
    return formatter.string(from: self)
  }
  
  /// A quick way to convert a String to a date using a known style.
  /// - parameter dateString: The styled Date as a String.
  /// - parameter dateStyle: The known style of the date.
  /// - parameter timeStyle: The known style of the time.
  /// - returns: The created Date object.
  public static func create(
    from dateString: String,
    with dateStyle: DateFormatter.Style = .short,
    and timeStyle: DateFormatter.Style = .none) -> Date? {
    
    let formatter = DateFormatter()
    formatter.dateStyle = dateStyle
    formatter.timeStyle = timeStyle
    return formatter.date(from: dateString)
  }
}
