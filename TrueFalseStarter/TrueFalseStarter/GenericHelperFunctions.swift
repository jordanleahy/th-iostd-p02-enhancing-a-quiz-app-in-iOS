//
//  GenericHelperFucntions.swift
//  TrueFalseStarter
//
//  Created by Martin Wilter on 6/28/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import UIKit

// Returns random int from closed or half-open range, default is half-open range
func randomIntWithUpperBound(upperBound: Int, includeUpperBound: Bool = false) -> Int {

    if includeUpperBound {
        return Int(arc4random() % UInt32(upperBound + 1))
    }

    return Int(arc4random() % UInt32(upperBound))
}

// Returns UIColor from hex string
// Source: http://stackoverflow.com/a/27203691/6275291
func hexStringToUIColor (hex:String) -> UIColor {
    var cString:String = hex.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet() as NSCharacterSet).uppercaseString

    if (cString.hasPrefix("#")) {
        cString = cString.substringFromIndex(cString.startIndex.advancedBy(1))
    }

    if ((cString.characters.count) != 6) {
        return UIColor.grayColor()
    }

    var rgbValue:UInt32 = 0
    NSScanner(string: cString).scanHexInt(&rgbValue)

    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}

