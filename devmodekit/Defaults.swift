import Foundation

/// Easily get and set user defaults.
open class Defaults {
  
  open class var standard: Defaults {
    struct Singleton {
      static let instance = Defaults(defaults: UserDefaults.standard)
    }
    return Singleton.instance
  }
  
  open class var group: Defaults {
    struct Singleton {
      static let instance = Defaults(defaults: UserDefaults(suiteName: "group.some.group.name")!)
    }
    return Singleton.instance
  }
  
  fileprivate let defaults: UserDefaults
  
  public init(defaults: UserDefaults) {
    self.defaults = defaults
  }
  
  subscript(key: String) -> AnyObject? {
    get {
      return defaults.object(forKey: key) as AnyObject?
    }
    set {
      defaults.set(newValue, forKey: key)
      defaults.synchronize()
    }
  }
  
  public func booleanFor(_ key: String) -> Bool {
    return defaults.bool(forKey: key)
  }
  
  public func setBoolFor(_ key: String, value: Bool) {
    defaults.set(value, forKey: key)
    defaults.synchronize()
  }
}
