//
//  AggregateKeyPath.swift
//  CDG
//
//  Copyright © 2021 LotusFlare. All rights reserved.
//

import Foundation

public enum AggregateOperation: String {
    case count = "count:"
    case min = "min:"
    case max = "max:"
    case average = "average:"
    case sum = "sum:"
}

public struct AggregateKeyPath<Root>: ComparablePredicate {
    let operation: AggregateOperation
    let collectionExpression: NSExpression
    
    init<RootType: Persistable, CollectionType: Collection, KeyPathType: KeyPath<RootType, CollectionType>>(
        operation: AggregateOperation, keyPath: KeyPathType
    ) {
        self.operation = operation
        self.collectionExpression = keyPath.keyPathExpression
    }
    
    
    public func predicate(op: NSComparisonPredicate.Operator, value: Any?) -> ComparisonPredicate<Root> {
        return ComparisonPredicate(leftExpression: NSExpression(forFunction: operation.rawValue, arguments: [collectionExpression]),
                                   rightExpression: NSExpression(forConstantValue: value),
                                   modifier: .direct, type: op, options: [])
    }
    
}

public func count<RootType: Persistable, CollectionType: Collection, KeyPathType: KeyPath<RootType, CollectionType>>(_
    keyPath: KeyPathType
) -> AggregateKeyPath<RootType> {
    return AggregateKeyPath(operation: .count, keyPath: keyPath)
}

public func min<RootType: Persistable, CollectionType: Collection, KeyPathType: KeyPath<RootType, CollectionType>>(_
    keyPath: KeyPathType
) -> AggregateKeyPath<RootType> {
    return AggregateKeyPath(operation: .min, keyPath: keyPath)
}

public func max<RootType: Persistable, CollectionType: Collection, KeyPathType: KeyPath<RootType, CollectionType>>(_
    keyPath: KeyPathType
) -> AggregateKeyPath<RootType> {
    return AggregateKeyPath(operation: .max, keyPath: keyPath)
}

public func average<RootType: Persistable, CollectionType: Collection, KeyPathType: KeyPath<RootType, CollectionType>>(_
    keyPath: KeyPathType
) -> AggregateKeyPath<RootType> {
    return AggregateKeyPath(operation: .average, keyPath: keyPath)
}
    
public func sum<RootType: Persistable, CollectionType: Collection, KeyPathType: KeyPath<RootType, CollectionType>>(_
    keyPath: KeyPathType
) -> AggregateKeyPath<RootType> {
    return AggregateKeyPath(operation: .sum, keyPath: keyPath)
}
