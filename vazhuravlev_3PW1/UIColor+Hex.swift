//
//  UIColor+Hex.swift
//  vazhuravlev_3PW1
//
//  Created by valeriy.zhuravlev on 15.09.2022.
//

import UIKit

extension UIColor {
    convenience init?(hexString: String) {
        let r, g, b: CGFloat
        let start = hexString.index(hexString.startIndex, offsetBy: 1)
        let hexColor = String(hexString[start...])
        if hexColor.count == 6 {
            let scanner = Scanner(string: hexColor)
            var hexNumber: UInt64 = 0

            if scanner.scanHexInt64(&hexNumber) {
                r = CGFloat((hexNumber & 0xff0000) >> 16) / 255
                g = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
                b = CGFloat(hexNumber & 0x0000ff) / 255
                self.init(red: r, green: g, blue: b, alpha: 1)
                return
            }
        }
        return nil
    }
}
