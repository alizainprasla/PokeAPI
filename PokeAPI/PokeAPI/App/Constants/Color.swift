//
//  Color.swift
//  PokeAPI
//
//  Created by Alizain on 02/08/2022.
//

import Foundation
import UIKit

struct Color {
    static let background = UIColor(hex: 0xF5F5F5)
    static let primary = UIColor(hex: 0x282828)
    static let secondary = UIColor(hex: 0xE88F3D)
    static let surface = UIColor(hex: 0xFFFFFF)
    static let categorySurface = UIColor(hex: 0xA4A3B5)
    
    static private let gridGreen = UIColor(hex: 0x4FC1A8)
    static private let gridRed = UIColor(hex: 0xFC6C6D)
    static private let gridBlue = UIColor(hex: 0x58A9F4)
    static private let gridYellow = UIColor(hex: 0xFFCE4B)
    
    static func randomGridColor() -> UIColor {
        let random = Int.random(in: 0...666)
        if random % 2 == 0 && random % 3 == 0  {
            return gridGreen
        } else if random % 3 == 0 {
            return gridRed
        } else if random % 5 == 0 {
            return gridBlue
        } else {
            return gridYellow
        }
    }
}

public extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")

        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }

    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        self.init(red: CGFloat((hex >> 16) & 0xff) / CGFloat(255.0),
                  green: CGFloat((hex >> 8) & 0xff) / CGFloat(255.0),
                  blue: CGFloat(hex & 0xff) / CGFloat(255.0),
                  alpha: alpha)
    }
}
