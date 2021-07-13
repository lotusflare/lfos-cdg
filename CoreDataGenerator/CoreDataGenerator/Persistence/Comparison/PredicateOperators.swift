//
//  PredicateOperators.swift
//  CDG
//
//  Copyright © 2021 LotusFlare. All rights reserved.
//

import Foundation

public func ==<EquatableType: Equatable, KeyPathType: ComparablePredicate>(
    left: KeyPathType, right: EquatableType
) -> ComparisonPredicate<KeyPathType.Root> {
    return left.predicate(op: .equalTo, value: right)
}

public func !=<EquatableType: Equatable, KeyPathType: ComparablePredicate>(
    left: KeyPathType, right: EquatableType
) -> ComparisonPredicate<KeyPathType.Root> {

    return left.predicate(op: .notEqualTo, value: right)
}

public func ><EquatableType: Equatable, KeyPathType: ComparablePredicate>(
    left: KeyPathType, right: EquatableType
) -> ComparisonPredicate<KeyPathType.Root> {

    return left.predicate(op: .greaterThan, value: right)
}

public func <<EquatableType: Equatable, KeyPathType: ComparablePredicate>(
    left: KeyPathType, right: EquatableType
) -> ComparisonPredicate<KeyPathType.Root> {

    return left.predicate(op: .lessThan, value: right)
}

public func >=<EquatableType: Equatable, KeyPathType: ComparablePredicate>(
    left: KeyPathType, right: EquatableType
) -> ComparisonPredicate<KeyPathType.Root> {

    return left.predicate(op: .greaterThanOrEqualTo, value: right)
}

public func <=<EquatableType: Equatable, KeyPathType: ComparablePredicate>(
    left: KeyPathType, right: EquatableType
) -> ComparisonPredicate<KeyPathType.Root> {

    return left.predicate(op: .lessThanOrEqualTo, value: right)
}

/// Operator used to map left and right operands to an equivalent NSPredicate:
/// NSPredicate(format: "`left` IN %@", `right`)
/// `right` operand must be a Sequence`
/// - Parameters:
///   - left: Left side of the operation must be a keypath which will point at a property which has the same type as an Element of the right operand
///   - right: Sequence of elements
public func ===<RootType, SequenceType: Sequence>(
    left: KeyPath<RootType, SequenceType.Element>, right: SequenceType
) -> ComparisonPredicate<RootType> where SequenceType.Element: Equatable {

    return left.predicate(op: .in, value: right)
}
