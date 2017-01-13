import Foundation

/// A structured logging framework for iOS applications.
public class Logger {
  
  /// A function returning a String to use for a log statement.
  public typealias MessageCreator = () -> String
  
  /// The current logging level.
  public static var currentLevel: Level = .error
  
  /// A String indicating the category the logger.
  public let category: String
  
  /// An enumeration of traditional logging levels - debug, info, warning, and error.
  public enum Level: Int {
    
    case debug = 0, info = 1, warning = 2, error = 4
    
    /// The name of the level.
    var name: String {
      switch self {
        case .debug: return "DEBUG"
        case .info: return "INFO"
        case .warning: return "WARNING"
        case .error: return "ERROR"
      }
    }
  }
  
  /// Initialize a logger instance based on a specific category.
  public init(category: String) {
    self.category = category
  }
  
  // MARK: Class Functions
  
  /// Print a log statement.
  /// - parameter category: The category of the log statement.
  /// - parameter level: The level of the log statement.
  /// - parameter message: The log message.
  public class func log(category: String, level: Level, message: String) {
    if level.rawValue >= currentLevel.rawValue {
      NSLog("\(level.name) - \(category): \(message)")
    }
  }
  
  /// Print a log statement based on a message creator.
  /// - parameter category: The category of the log statement.
  /// - parameter level: The level of the log statement.
  /// - parameter messageCreator: The message creator.
  public class func log(category: String, level: Level, messageCreator: MessageCreator) {
    if level.rawValue >= currentLevel.rawValue {
      log(category: category, level: level, message: messageCreator())
    }
  }
  
  /// Print a debug log statement.
  /// - parameter category: The category of the log statement.
  /// - parameter message: The log message.
  public class func debug(category: String, message: String) {
    log(category: category, level: .debug, message: message)
  }
  
  /// Print a debug log statement based on a message creator.
  /// - parameter category: The category of the log statement.
  /// - parameter messageCreator: The message creator.
  public class func debug(category: String, messageCreator: MessageCreator) {
    log(category: category, level: .debug, messageCreator: messageCreator)
  }
  
  /// Print an info log statement.
  /// - parameter category: The category of the log statement.
  /// - parameter message: The log message.
  public class func info(category: String, message: String) {
    log(category: category, level: .info, message: message)
  }
  
  /// Print an info log statement based on a message creator.
  /// - parameter category: The category of the log statement.
  /// - parameter messageCreator: The message creator.
  public class func info(category: String, messageCreator: MessageCreator) {
    log(category: category, level: .info, messageCreator: messageCreator)
  }
  
  /// Print a warning log statement.
  /// - parameter category: The category of the log statement.
  /// - parameter level: The level of the log statement.
  /// - parameter message: The log message.
  public class func warning(category: String, message: String) {
    log(category: category, level: .warning, message: message)
  }
  
  /// Print a warning log statement based on a message creator.
  /// - parameter category: The category of the log statement.
  /// - parameter messageCreator: The message creator.
  public class func warning(category: String, messageCreator: MessageCreator) {
    log(category: category, level: .warning, messageCreator: messageCreator)
  }
  
  /// Print an error log statement.
  /// - parameter category: The category of the log statement.
  /// - parameter level: The level of the log statement.
  /// - parameter message: The log message.
  public class func error(category: String, message: String) {
    log(category: category, level: .error, message: message)
  }
  
  /// Print an error log statement based on a message creator.
  /// - parameter category: The category of the log statement.
  /// - parameter messageCreator: The message creator.
  public class func error(category: String, messageCreator: MessageCreator) {
    log(category: category, level: .error, messageCreator: messageCreator)
  }
  
  // MARK: Instance Functions
  
  /// Print a log statement.
  /// - parameter level: The level of the log statement.
  /// - parameter message: The log message.
  public func log(level: Level, message: String) {
    Logger.log(category: category, level: level, message: message)
  }
  
  /// Print a log statement based on a message creator.
  /// - parameter level: The level of the log statement.
  /// - parameter messageCreator: The message creator.
  public func log(level: Level, messageCreator: MessageCreator) {
    Logger.log(category: category, level: level, messageCreator: messageCreator)
  }
  
  /// Print a debug log statement.
  /// - parameter message: The log message.
  public func debug(message: String) {
    Logger.debug(category: category, message: message)
  }
  
  /// Print a debug log statement based on a message creator.
  /// - parameter messageCreator: The message creator.
  public func debug(messageCreator: MessageCreator) {
    Logger.debug(category: category, messageCreator: messageCreator)
  }
  
  /// Print an info log statement.
  /// - parameter message: The log message.
  public func info(message: String) {
    Logger.info(category: category, message: message)
  }
  
  /// Print an info log statement based on a message creator.
  /// - parameter messageCreator: The message creator.
  public func info(messageCreator: MessageCreator) {
    Logger.info(category: category, messageCreator: messageCreator)
  }
  
  /// Print a warning log statement.
  /// - parameter message: The log message.
  public func warning(message: String) {
    Logger.warning(category: category, message: message)
  }
  
  /// Print a warning log statement based on a message creator.
  /// - parameter messageCreator: The message creator.
  public func warning(messageCreator: MessageCreator) {
    Logger.warning(category: category, messageCreator: messageCreator)
  }
  
  /// Print an error log statement.
  /// - parameter message: The log message.
  public func error(message: String) {
    Logger.error(category: category, message: message)
  }
  
  /// Print an error log statement based on a message creator.
  /// - parameter messageCreator: The message creator.
  public func error(messageCreator: MessageCreator) {
    Logger.error(category: category, messageCreator: messageCreator)
  }
}
