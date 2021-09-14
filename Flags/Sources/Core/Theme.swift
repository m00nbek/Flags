//
//  Theme.swift
//  Fursat
//
//  Created by NY on 29/07/21.
//

import UIKit

public struct Padding {
    
}

public extension Padding {
    static var s: CGFloat {
        if isDevice(.pad) {
            return 8
        } else {
            return 4
        }
    }
    
    static var m: CGFloat {
        if isDevice(.pad) {
            return 16
        } else {
            return 8
        }
    }
    
    static var l: CGFloat {
        if isDevice(.pad) {
            return 32
        } else {
            return 16
        }
    }
}

struct Color {
    static let primaryColor = UIColor(hex: "0043DE")
    
    static let secondaryColor = UIColor(hex: "00BFFF")
    
    static let blackColor = UIColor(hex: "000000")
    
    static let whiteColor = UIColor(hex: "E5E5E5")
    
    static let darkTextColor = UIColor(hex: "3F3F46")
    
    static let lightTextColor = UIColor(hex: "686868")
    
    static let inputBackground = UIColor(hex: "F8F8F8")
    
    static let inputBorder = UIColor(hex: "EBEEF0")
    
    static let mainDarkColor = UIColor(hex: "1d262b")
    static let mainLightColor = UIColor(hex: "343b41")
}

func styledText(_ text: String) -> NSMutableAttributedString {
    let attrString = NSMutableAttributedString(string: text)
    let style = NSMutableParagraphStyle()
    style.lineSpacing = 8.0
    attrString.addAttributes([NSAttributedString.Key.paragraphStyle : style], range: NSMakeRange(0, attrString.length))
    
    return attrString
}
