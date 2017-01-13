import Foundation

public extension URL {
  
  /// A parsed dictionary of query parameters.
  var parsedQuery: [String: String] {
    var results = [String: String]()
    if let pairs = query?.components(separatedBy: "&"), pairs.count > 0 {
      for pair: String in pairs {
        guard let keyValue = pair.components(separatedBy: "=") as [String]? else { continue }
        results.updateValue(keyValue[1], forKey: keyValue[0])
      }
    }
    return results
  }
}
