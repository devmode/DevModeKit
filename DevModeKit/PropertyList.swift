import Foundation

/// Easily pull values from property list files based on the app environment using subscripts.
open class PropertyList {
  
  private let dictionary: NSDictionary
  
  /// The environment for the application.
  open static var environment: Environment = .production
  
  /// The main property list for the application, which is determined by the enironment.
  open static var main: PropertyList {
    struct Singleton {
      static let instance = PropertyList(name: "\(PropertyList.environment)")
    }
    return Singleton.instance
  }
  
  /// An enumeration of potential app environments - test, staging, staging2, or production.
  public enum Environment: Int {
    case test = 0, staging = 1, staging2 = 2, production = 3
    var name: String {
      switch self {
        case .test: return "Test"
        case .staging: return "Staging"
        case .staging2: return "Staging2"
        case .production: return "Production"
      }
    }
  }
  
  /// Initializes a property list object based on the file name.
  /// - parameter name: The file name of the property list.
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
  
  subscript(key: String) -> Entry {
    get {
      return Entry(value: fetch(key: key))
    }
  }
}
