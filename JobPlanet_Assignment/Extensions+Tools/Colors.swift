//
//  Colors.swift
//  JobPlanet_Assignment
//
//  Created by John Hur on 2023/10/16.
//

import UIKit

enum JobPlanetFont {
    case Bold // 700
    case SemiBold // 600
    case Regular // 500
    case Medium // 400
    
    var font: String {
        switch self {
        case .Bold: return "AppleSDGothicNeo-Bold"
        case .SemiBold: return "AppleSDGothicNeo-SemiBold"
        case .Regular: return "AppleSDGothicNeo-Regular"
        case .Medium: return "AppleSDGothicNeo-Medium"
        }
    }
}

enum JobplanetColor {
    case Green
    case Blue
    case Red
    case Gray01
    case Gray02
    case Gray03

    var color: UIColor {
        switch self {
        case .Green: return UIColor(hex: "00C362")
        case .Blue: return UIColor(hex: "0994FF")
        case .Red: return UIColor(hex: "FF5757")
        case .Gray01: return UIColor(hex: "323438")
        case .Gray02: return UIColor(hex: "686A6D")
        case .Gray03: return UIColor(hex: "E5E6E9")
        }
    }
}


// To Hex Value
extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0

        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
