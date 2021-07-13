//
//  KeyPathPredicate.swift
//  CDG
//
//  Copyright © 2021 LotusFlare. All rights reserved.
//

import Foundation

public protocol ComparablePredicate {
    associatedtype Root
    func predicate(op: NSComparisonPredicate.Operator, value: Any?) -> ComparisonPredicate<Root>
}

extension KeyPath: ComparablePredicate {
    var keyPathExpression: NSExpression {
        if let RootType = NSClassFromString("Managed\(type(of: self).rootType)") as? KeyPathable.Type {
            return NSExpression(forKeyPath: RootType.managedKeyPathFrom(self))
        } else {
            return NSExpression(forKeyPath: self)
        }
    }

    public func predicate(op: NSComparisonPredicate.Operator, value: Any?) -> ComparisonPredicate<Root> {
        return ComparisonPredicate(leftExpression: keyPathExpression,
                                   rightExpression: NSExpression(forConstantValue: value),
                                   modifier: .direct, type: op)
    }
    
    var stringKeyPath: String {
        return NSExpression(forKeyPath: self).keyPath
    }
}

public struct LFKeyPath {
    let stringKeyPath: String
    
    init(keyPath: String) {
        stringKeyPath = keyPath
    }
}

public protocol KeyPathable {
    static func managedKeyPathFrom<EntityType, VariableType>(_ plainKeyPath: KeyPath<EntityType, VariableType>) -> String
}
