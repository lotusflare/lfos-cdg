//
//  ComparisonClause.swift
//  CDG
//
//  Copyright © 2021 LotusFlare. All rights reserved.
//

import Foundation

public struct ComparisonClause {
    let sortDescriptor: NSSortDescriptor
    public static func ascending<EntityType: Persistable, PropertyType>(_ keyPath: KeyPath<EntityType, PropertyType>) -> ComparisonClause {
        return ComparisonClause(sortDescriptor: NSSortDescriptor(key: keyPath.keyPathExpression.keyPath, ascending: true))
    }
    
    public static func descending<EntityType: Persistable, PropertyType>(_ keyPath: KeyPath<EntityType, PropertyType>) -> ComparisonClause {
        return ComparisonClause(sortDescriptor: NSSortDescriptor(key: keyPath.keyPathExpression.keyPath, ascending: false))
    }
}
