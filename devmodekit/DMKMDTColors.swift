//
//  DMKMDTColors.swift
//  devmodekit
//
//  Created by Nick Pappas on 5/12/16.
//  Copyright © 2016 DevMode. All rights reserved.
//

import Foundation

public extension UIColor {
    
    static func rgb(r: Int, _ g: Int, _ b: Int, alpha: Int = 100) -> UIColor {
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(alpha) / 100.0)
    }
    
    static func gray(comp: Int, alpha: Int = 100) -> UIColor {
        return rgb(comp, comp, comp, alpha: alpha)
    }
    
    static var mdtNavy : UIColor {
        return rgb(0, 30, 70)
    }
    
    static var mdtCobolt : UIColor {
        return rgb(0, 133, 202)
    }
    
    static var mdtSkyBlue : UIColor {
        return rgb(113, 197, 232)
    }
    
    static var mdtBlue : UIColor {
        return rgb(0, 75, 135)
    }
    
    static var mdtMediumBlue : UIColor {
        return rgb( 0, 169, 224)
    }
    
    static var mdtLightBlue : UIColor {
        return rgb(185, 217, 235)
    }
    
    static var mdtBlueGray : UIColor {
        return rgb(91, 127, 149)
    }
    
    static var mdtLightGray : UIColor {
        return rgb(177, 179, 179)
    }
    
    static var mdtDarkGray : UIColor {
        return rgb(136, 139, 141)
    }
    
    static var mdtYellow : UIColor {
        return rgb(255, 206, 0)
    }
    
    static var mdtOrange : UIColor {
        return rgb(227, 82, 5)
    }
    
    static var mdtGreen : UIColor {
        return rgb(119, 188, 31)
    }
    
    static var mdtLightOrange : UIColor {
        return rgb(247, 168, 0)
    }
    
    static var mdtLightPurple : UIColor {
        return rgb(176, 0, 142)
    }
    
    static var mdtTurquoise : UIColor {
        return rgb(0, 196, 179)
    }
}