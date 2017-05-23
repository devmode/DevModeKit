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
  
  init(defaults: UserDefaults) {
    self.defaults = defaults
  }

  
  public subscript(key: String) -> Any? {
    get {
      return defaults.object(forKey: key)
    }
    set {
      defaults.set(newValue, forKey: key)
      defaults.synchronize()
    }
  }
  
  public subscript(key: String) -> String? {
    get {
      return defaults.string(forKey: key)
    }
    set {
      defaults.set(newValue, forKey: key)
      defaults.synchronize()
    }
  }
  
  public subscript(key: String) -> Int {
    get {
      return defaults.integer(forKey: key)
    }
    set {
      defaults.set(newValue, forKey: key)
      defaults.synchronize()
    }
  }
  
  public subscript(key: String) -> Bool {
    get {
      return defaults.bool(forKey: key)
    }
    set {
      defaults.set(newValue, forKey: key)
      defaults.synchronize()
    }
  }
  
  public subscript(key: String) -> Double {
    get {
      return defaults.double(forKey: key)
    }
    set {
      defaults.set(newValue, forKey: key)
      defaults.synchronize()
    }
  }
  
  public subscript(key: String) -> Data? {
    get {
      return defaults.data(forKey: key)
    }
    set {
      defaults.set(newValue, forKey: key)
      defaults.synchronize()
    }
  }
  public subscript(key: String) -> Date? {
    get {
      return defaults.object(forKey: key) as? Date
    }
    set {
      defaults.set(newValue, forKey: key)
      defaults.synchronize()
    }
  }
  
  public func store<T: NSObjectProtocol & NSCoding>(key: String, object: T) {
    defaults.set(NSKeyedArchiver.archivedData(withRootObject: object), forKey: key)
    defaults.synchronize()
  }
  
  public func load<T: NSObjectProtocol & NSCoding>(key: String) -> T? {
    if let data : Data = self[key] {
      return NSKeyedUnarchiver.unarchiveObject(with: data) as? T
    }
    return nil
  }

  
}
