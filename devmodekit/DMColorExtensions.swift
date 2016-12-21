import UIKit

/// Additional color-related functionality.
public extension UIColor {
  
  public class func rgb(_ red: Int, _ green: Int, _ blue: Int, _ alpha: Int = 100) -> UIColor {
    return UIColor(
      red: CGFloat(red) / CGFloat(255),
      green: CGFloat(green) / CGFloat(255),
      blue: CGFloat(blue) / CGFloat(255),
      alpha: CGFloat(alpha) / CGFloat(100)
    )
  }
  
  public class func gray(_ component: Int, alpha: Int = 100) -> UIColor {
    return rgb(component, component, component, alpha)
  }
}
