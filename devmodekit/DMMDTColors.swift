import Foundation

public extension UIColor {
    
    static func rgb(r: Int, g: Int, b: Int, alpha: Int = 100) -> UIColor {
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(alpha) / 100.0)
    }
    
    static func gray(comp: Int, alpha: Int = 100) -> UIColor {
        return rgb(r: comp, g: comp, b: comp, alpha: alpha)
    }
    
    static var mdtNavy : UIColor {
        return rgb(r: 0, g: 30, b: 70)
    }
    
    static var mdtCobolt : UIColor {
        return rgb(r: 0, g: 133, b: 202)
    }
    
    static var mdtSkyBlue : UIColor {
        return rgb(r: 113, g: 197, b: 232)
    }
    
    static var mdtBlue : UIColor {
        return rgb(r: 0, g: 75, b: 135)
    }
    
    static var mdtMediumBlue : UIColor {
        return rgb( r: 0, g: 169, b: 224)
    }
    
    static var mdtLightBlue : UIColor {
        return rgb(r: 185, g: 217, b: 235)
    }
    
    static var mdtBlueGray : UIColor {
        return rgb(r: 91, g: 127, b: 149)
    }
    
    static var mdtLightGray : UIColor {
        return rgb(r: 177, g: 179, b: 179)
    }
    
    static var mdtDarkGray : UIColor {
        return rgb(r: 136, g: 139, b: 141)
    }
    
    static var mdtYellow : UIColor {
        return rgb(r: 255, g: 206, b: 0)
    }
    
    static var mdtOrange : UIColor {
        return rgb(r: 227, g: 82, b: 5)
    }
    
    static var mdtGreen : UIColor {
        return rgb(r: 119, g: 188, b: 31)
    }
    
    static var mdtLightOrange : UIColor {
        return rgb(r: 247, g: 168, b: 0)
    }
    
    static var mdtLightPurple : UIColor {
        return rgb(r: 176, g: 0, b: 142)
    }
    
    static var mdtTurquoise : UIColor {
        return rgb(r: 0, g: 196, b: 179)
    }
}
