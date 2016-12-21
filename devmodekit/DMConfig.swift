import Foundation

/// Easily pull values from configuration pList files.
open class DMConfig {
  
  private let dictionary: NSDictionary
  
  open static var currentEnvironment: Environment = .Production
  open static var currentVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "Unknown"
  
  open static var sharedInstance: DMConfig {
    struct Singleton {
      static let instance = DMConfig(name: "Config-\(DMConfig.currentEnvironment)")
    }
    return Singleton.instance
  }
  
  public enum Environment: Int {
    case Test = 0, Staging = 1, Staging2 = 2, Production = 3
    var name: String {
      switch self {
        case .Test: return "Test"
        case .Staging: return "Staging"
        case .Staging2: return "Staging2"
        case .Production: return "Production"
      }
    }
  }
  
  struct Entry {
    
    private let value: AnyObject?
    
    var string: String {
      guard let value = self.value as? String else { return "" }
      return value
    }
    
    var integer: Int {
      guard let value = self.value as? Int else { return -1 }
      return value
    }
    
    var double: Double {
      guard let value = self.value as? Double else { return -1 }
      return value
    }
    
    var boolean: Bool {
      guard let value = self.value as? Bool else { return false }
      return value
    }
    
    init(value: AnyObject?) {
      self.value = value
    }
  }
  
  public init(name: String) {
    let path = Bundle.main.path(forResource: name, ofType: "plist")
    var dictionary: NSDictionary?
    if let path = path {
      dictionary = NSDictionary(contentsOfFile: path)
    }
    self.dictionary = dictionary ?? NSDictionary()
  }
  
  private func fetch(key: String) -> AnyObject? {
    guard let container = containerFor(dictionary: dictionary, path: key.components(separatedBy: ".")) else { return nil }
    return container.object(forKey: key.components(separatedBy: ".").last!) as AnyObject?
  }
  
  private func containerFor(dictionary: NSDictionary, path: Array<String>) -> NSDictionary? {
    guard path.count > 0 else { return dictionary }
    guard let container = dictionary[path[0]] as? NSDictionary else { return nil }
    guard path[1 ..< path.count].count > 1 else { return container }
    return containerFor(dictionary: container, path: Array(path[1 ..< path.count]))
  }
  
  subscript(key: String) -> Entry {
    get {
      return Entry(value: fetch(key: key))
    }
  }
}
