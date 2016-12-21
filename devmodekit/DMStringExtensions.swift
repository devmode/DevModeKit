/// Additional string-related functionality.
public extension String {
  
  var numeric: String {
    var numeric = self
    let charactersToRemove = ["-", " ", "(", ")", "+", "~", "!", "@", "#", "$", "%", "^", "&", "*", "=", ":", "?", ".", ","]
    for character in charactersToRemove {
      numeric = numeric.replacingOccurrences(of: character, with: "", options: .literal, range: nil)
    }
    return numeric
  }
  
  var formattedPhoneNumber: String {
    var phoneNumber = self.numeric
    let dash = "-"
    let open = "("
    let close = ") "
    let length = NSString(string: phoneNumber).length
    if length > 0 {
      phoneNumber = phoneNumber.insert(dash, atIndex: length - 4)
      phoneNumber = phoneNumber.insert(close, atIndex: length - 7)
      phoneNumber = phoneNumber.insert(open, atIndex: length - 10)
    }
    return length == 11 ? phoneNumber.replacingOccurrences(of: "1(", with: "(") : phoneNumber
  }
  
  var plural: String {
    return NSString(string: self).contains("s") ? self : self + "s"
  }
  
  var singular: String {
    guard let range = self.range(of: "s") else { return self }
    return self.substring(with: range)
  }
  
  var base64Encoded: String {
    let plainData = data(using: String.Encoding.utf8)
    guard let base64String = plainData?.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0)) else { return self }
    return base64String
  }
  
  var base64Decoded: String {
    guard let decodedData = Data(base64Encoded: self, options:NSData.Base64DecodingOptions(rawValue: 0)) else { return self }
    guard let decodedNSString = NSString(data: decodedData, encoding: String.Encoding.utf8.rawValue) else { return "" }
    return decodedNSString as String
  }
  
  func insert(_ string: String, atIndex: Int) -> String {
    return String(self.characters.prefix(atIndex)) + string + String(self.characters.suffix(self.characters.count - atIndex))
  }
  
  func bytesFromBase64() -> [UInt8]? {
    guard let data = Data(base64Encoded: self, options: []) else { return nil }
    var bytes = [UInt8](repeating: 0, count: data.count)
    (data as NSData).getBytes(&bytes, length: data.count)
    return bytes
  }
  
  func paramEscape() -> String {
    
    // does not include "?" or "/" due to RFC 3986 - Section 3.4
    let generalDelimitersToEncode = ":#[]@"
    let subDelimitersToEncode = "!$&'()*+,;="
    var newCharSet = NSCharacterSet.urlQueryAllowed
    newCharSet.remove(charactersIn: generalDelimitersToEncode + subDelimitersToEncode)
    return addingPercentEncoding(withAllowedCharacters: newCharSet) ?? ""
  }
  
  subscript (i: Int) -> Character {
    return self[self.characters.index(self.startIndex, offsetBy: i)]
  }
  
  subscript (i: Int) -> String {
    return String(self[i] as Character)
  }
  
  subscript (r: Range<Int>) -> String {
    return substring(with: characters.index(startIndex, offsetBy: r.lowerBound)..<characters.index(startIndex, offsetBy: r.upperBound))
  }
}
