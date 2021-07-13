//
//  CompoundKeyPath.swift
//  CDG
//
//  Copyright © 2021 LotusFlare. All rights reserved.
//

import Foundation

public class CompoundKeyPath<Root>: ComparablePredicate {
    let compoundKeyPath: String
    let modifier: NSComparisonPredicate.Modifier
    let rootExpression: NSExpression
    let relationshipVariable: String

    public init<
    RootType, RelationshipType: Persistable, EquatableType: Equatable, CollectionType: Collection,
    RootKeyPathType: KeyPath<RootType, CollectionType>,
    ChildKeyPathType: KeyPath<RelationshipType, EquatableType>>
        (rootKeyPath: RootKeyPathType, relationshipKeyPath: ChildKeyPathType, modifier: NSComparisonPredicate.Modifier) where CollectionType.Element == RelationshipType {

        self.rootExpression = rootKeyPath.keyPathExpression
        self.relationshipVariable = rootKeyPath.keyPathExpression.keyPath
        self.compoundKeyPath = "$value.\(relationshipKeyPath.keyPathExpression.keyPath)"
        self.modifier = modifier
    }

    public init<
    RootType, RelationshipType: Persistable, EquatableType: Equatable, CollectionType: Collection,
    RootKeyPathType: KeyPath<RootType, CollectionType?>,
    ChildKeyPathType: KeyPath<RelationshipType, EquatableType>>
        (rootKeyPath: RootKeyPathType, relationshipKeyPath: ChildKeyPathType, modifier: NSComparisonPredicate.Modifier) where CollectionType.Element == RelationshipType {
        
        self.rootExpression = rootKeyPath.keyPathExpression
        self.relationshipVariable = rootKeyPath.keyPathExpression.keyPath
        self.compoundKeyPath = "$value.\(relationshipKeyPath.keyPathExpression.keyPath)"
        self.modifier = modifier
    }
    
    public init<
    RootType, RelationshipType: Persistable, EquatableType: Equatable,
    RootKeyPathType: KeyPath<RootType, NSOrderedSet>,
    ChildKeyPathType: KeyPath<RelationshipType, EquatableType>>
        (rootKeyPath: RootKeyPathType, relationshipKeyPath: ChildKeyPathType, modifier: NSComparisonPredicate.Modifier) {
        
        self.rootExpression = rootKeyPath.keyPathExpression
        self.relationshipVariable = rootKeyPath.keyPathExpression.keyPath
        self.compoundKeyPath = "$value.\(relationshipKeyPath.keyPathExpression.keyPath)"
        self.modifier = modifier
    }
    
    public func predicate(op: NSComparisonPredicate.Operator, value: Any?) -> ComparisonPredicate<Root> {
        var countExpression = NSExpression(forConstantValue: 0)
        var operatorType: NSComparisonPredicate.Operator = .greaterThan
        
        if modifier == .all {
            countExpression = NSExpression(forKeyPath: "\(relationshipVariable).@count")
            operatorType = .equalTo
        }

        return ComparisonPredicate<Root>(leftExpression: count(NSExpression(forSubquery: rootExpression,
                                                                            usingIteratorVariable: "value",
                                                                            predicate: ComparisonPredicate<Root>(leftExpression: NSExpression(forKeyPath: compoundKeyPath),
                                                                                                                 rightExpression: NSExpression(forConstantValue: value),
                                                                                                                 modifier: .direct, type: op))),
                                         rightExpression: countExpression,
                                         modifier: .direct, type: operatorType, options: [])
    }
    
    func count(_ expression: NSExpression) -> NSExpression {
        return NSExpression(forFunction: "count:", arguments: [expression])
    }
}

public func all<
    RootType, RelationshipType: Persistable, EquatableType: Equatable, CollectionType: Collection,
    RootKeyPathType: KeyPath<RootType, CollectionType?>,
    ChildKeyPathType: KeyPath<RelationshipType, EquatableType>>(_ rootKeyPath: RootKeyPathType, _ relationshipKeyPath: ChildKeyPathType)
    -> CompoundKeyPath<RootType> where CollectionType.Element == RelationshipType {
        return CompoundKeyPath(rootKeyPath: rootKeyPath, relationshipKeyPath: relationshipKeyPath, modifier: .all)
}

public func all<
    RootType, RelationshipType: Persistable, EquatableType: Equatable,
    RootKeyPathType: KeyPath<RootType, NSOrderedSet>,
    ChildKeyPathType: KeyPath<RelationshipType, EquatableType>>(_ rootKeyPath: RootKeyPathType, _ relationshipKeyPath: ChildKeyPathType)
    -> CompoundKeyPath<RootType> {
        return CompoundKeyPath(rootKeyPath: rootKeyPath, relationshipKeyPath: relationshipKeyPath, modifier: .all)
}

public func any<
    RootType, RelationshipType: Persistable, EquatableType: Equatable, CollectionType: Collection,
    RootKeyPathType: KeyPath<RootType, CollectionType?>,
    ChildKeyPathType: KeyPath<RelationshipType, EquatableType>>(_ rootKeyPath: RootKeyPathType, _ relationshipKeyPath: ChildKeyPathType)
    -> CompoundKeyPath<RootType> where CollectionType.Element == RelationshipType {
        return CompoundKeyPath(rootKeyPath: rootKeyPath, relationshipKeyPath: relationshipKeyPath, modifier: .any)
}

public func any<
    RootType, RelationshipType: Persistable, EquatableType: Equatable,
    RootKeyPathType: KeyPath<RootType, NSOrderedSet>,
    ChildKeyPathType: KeyPath<RelationshipType, EquatableType>>(_ rootKeyPath: RootKeyPathType, _ relationshipKeyPath: ChildKeyPathType)
    -> CompoundKeyPath<RootType> {
        return CompoundKeyPath(rootKeyPath: rootKeyPath, relationshipKeyPath: relationshipKeyPath, modifier: .any)
}

