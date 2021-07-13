//
//  Globals.swift
//  CDG
//
//  Copyright © 2021 LotusFlare. All rights reserved.
//

import Foundation

public func memoryAddress<T: AnyObject>(of object: T) -> String {
    return String(format: "%p", unsafeBitCast(object, to: Int.self))
}
