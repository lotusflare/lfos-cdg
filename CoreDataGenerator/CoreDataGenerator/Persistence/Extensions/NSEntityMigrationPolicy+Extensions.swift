//
//  NSEntityMigrationPolicy+Extensions.swift
//  CDG
//
//  Copyright © 2021 LotusFlare. All rights reserved.
//

import CoreData

public extension NSEntityMigrationPolicy {
    static var className: String {
        guard let projectName = Bundle.main.infoDictionary?[kCFBundleNameKey as String] as? String else { return "" }
        return projectName + ".\(Self.self)"
    }
}
