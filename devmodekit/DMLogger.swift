import Foundation

public class DMLogger {
  
  public enum Level : Int {
    case Debug = 0, Info = 1, Warning = 2, Error = 4
    var name : String {
      switch self {
        case .Debug: return "DEBUG"
        case .Info: return "INFO"
        case .Warning: return "WARNING"
        case .Error: return "ERROR"
      }
    }
  }
  
  public typealias MessageCreator = () -> String
  
  public static var currentLevel : Level = .Error
  
  public class func log(category: String, level: Level, message: String) {
    if level.rawValue >= currentLevel.rawValue {
      NSLog("\(level.name) - \(category): \(message)")
    }
  }
  
  public class func log(category: String, level: Level, messageCreator: MessageCreator) {
    if level.rawValue >= currentLevel.rawValue {
      log(category: category, level: level, message: messageCreator())
    }
  }
  
  public class func debug(category: String, message: String) {
    log(category: category, level: .Debug, message: message)
  }
  
  public class func debug(category: String, messageCreator: MessageCreator) {
    log(category: category, level: .Debug, messageCreator: messageCreator)
  }
  
  public class func info(category: String, message: String) {
    log(category: category, level: .Info, message: message)
  }
  
  public class func info(category: String, messageCreator: MessageCreator) {
    log(category: category, level: .Info, messageCreator: messageCreator)
  }
  
  public class func warning(category: String, message: String) {
    log(category: category, level: .Warning, message: message)
  }
  
  public class func warning(category: String, messageCreator: MessageCreator) {
    log(category: category, level: .Warning, messageCreator: messageCreator)
  }
  
  public class func error(category: String, message: String) {
    log(category: category, level: .Error, message: message)
  }
  
  public class func error(category: String, messageCreator: MessageCreator) {
    log(category: category, level: .Error, messageCreator: messageCreator)
  }
  
  public let category: String
  
  public init(category: String) {
    self.category = category
  }
  
  public func log(level: Level, message: String) {
    DMLogger.log(category: category, level: level, message: message)
  }
  
  public func log(level: Level, messageCreator: MessageCreator) {
    DMLogger.log(category: category, level: level, messageCreator: messageCreator)
  }
  
  public func debug(message: String) {
    DMLogger.debug(category: category, message: message)
  }
  
  public func debug(messageCreator: MessageCreator) {
    DMLogger.debug(category: category, messageCreator: messageCreator)
  }
  
  public func info(message: String) {
    DMLogger.info(category: category, message: message)
  }
  
  public func info(messageCreator: MessageCreator) {
    DMLogger.info(category: category, messageCreator: messageCreator)
  }
  
  public func warning(message: String) {
    DMLogger.warning(category: category, message: message)
  }
  
  public func warning(messageCreator: MessageCreator) {
    DMLogger.warning(category: category, messageCreator: messageCreator)
  }
  
  public func error(message: String) {
    DMLogger.error(category: category, message: message)
  }
  
  public func error(messageCreator: MessageCreator) {
    DMLogger.error(category: category, messageCreator: messageCreator)
  }
}
