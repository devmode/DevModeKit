import Foundation

public extension String {
    
    func paramEscape() -> String {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="
        
        var newCharSet = NSCharacterSet.urlQueryAllowed
        
        newCharSet.remove(charactersIn: generalDelimitersToEncode + subDelimitersToEncode)
        return addingPercentEncoding(withAllowedCharacters: newCharSet) ?? ""
    }
    
}

public extension URL {
    
    func parseQuery() -> [String: String] {
        var results = [String: String]()
        if let pairs = query?.components(separatedBy: "&") , pairs.count > 0 {
            for pair: String in pairs {
                if let keyValue = pair.components(separatedBy: "=") as [String]? {
                    results.updateValue(keyValue[1], forKey: keyValue[0])
                }
            }
        }
        return results
    }    
}
