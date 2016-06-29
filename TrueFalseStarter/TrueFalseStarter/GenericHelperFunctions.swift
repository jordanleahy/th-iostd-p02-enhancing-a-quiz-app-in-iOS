//
//  GenericHelperFucntions.swift
//  TrueFalseStarter
//
//  Created by Martin Wilter on 6/28/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import Foundation

// Returns random int from closed or half-open range, default is half-open range
func randomIntWithUpperBound(upperBound: Int, includeUpperBound: Bool = false) -> Int {

    if includeUpperBound {
        return Int(arc4random() % UInt32(upperBound + 1))
    }

    return Int(arc4random() % UInt32(upperBound))
}

