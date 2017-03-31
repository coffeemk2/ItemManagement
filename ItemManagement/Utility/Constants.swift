//
//  Constants.swift
//  ItemManagement
//
//  Created by maekawakazuma on 2017/03/31.
//  Copyright © 2017 maekawakazuma. All rights reserved.
//

import Foundation

struct Constants{
    
    struct Color{
        static let actBorrow = UIColor(hexStr: "#3F6775")
        static let actReturn = UIColor(hexStr: "#8D6F4D")
        static let main = UIColor(hexStr: "#C5D300")
        static let gray = UIColor(hexStr: "#9E9EA6")
        static let black = UIColor(hexStr: "#041E17")
        static let lightgray = UIColor(hexStr: "#B2B2B2")
    }

}

extension UIColor {
    /// RGBA を 0~255 で指定
    public convenience init(intRed red: Int, green: Int, blue: Int, alpha: CGFloat) {
        self.init(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha:alpha)
    }
    
    /// RGB を 0~255 で指定
    public convenience init(intRed red: Int, green: Int, blue: Int) {
        self.init(intRed: red, green: green, blue: blue, alpha: 1.0)
    }
    
    /// RGB を16進数で指定
    public convenience init(hex: UInt32) {
        let r = Int32((hex & 0xFF0000) >> 16)
        let g = Int32((hex & 0x00FF00) >> 8)
        let b = Int32(hex & 0x0000FF)
        
        self.init(intRed: Int(r), green: Int(g), blue: Int(b))
    }
    

    /// RGB を16進数文字列で指定
    public convenience init(hexStr: String) {
        let str = hexStr.replacingOccurrences(of: "#", with: "")
        
        let colorScanner = Scanner(string: str)
        var color: UInt32 = 0
        colorScanner.scanHexInt32(&color)
        
        self.init(hex: color)
    }
    

    

}
