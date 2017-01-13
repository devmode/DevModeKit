import Foundation

/// Easily retrieve and store persistent device-specific default values via subscript.
/// Uses UserDefaults to make the magic happen.
open class Defaults {
  
  private let defaults: UserDefaults
  
  /// Singleton for standard defaults.
  open class var standard: Defaults {
    struct Singleton {
      static let instance = Defaults(defaults: UserDefaults.standard)
    }
    return Singleton.instance
  }
  
  /// Singleton for group/suite defaults.
  open class var group: Defaults {
    struct Singleton {
      static let instance = Defaults(defaults: UserDefaults(suiteName: "group.some.group.name")!)
    }
    return Singleton.instance
  }
  
  init(defaults: UserDefaults) {
    self.defaults = defaults
  }
  
  /// Boolean-typed getter.
  /// - parameter key: The key for the boolean.
  /// - returns: The boolean value.
  public func booleanFor(_ key: String) -> Bool {
    return defaults.bool(forKey: key)
  }
  
  /// Boolean-typed setter.
  /// - parameter key: The key for the boolean.
  /// - parameter value: The boolean value.
  public func setBoolFor(_ key: String, value: Bool) {
    defaults.set(value, forKey: key)
    defaults.synchronize()
  }
  
  public subscript(key: String) -> AnyObject? {
    get {
      return defaults.object(forKey: key) as AnyObject?
    }
    set {
      defaults.set(newValue, forKey: key)
      defaults.synchronize()
    }
  }
}
