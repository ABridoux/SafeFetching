//
// SafeFetching
// Copyright © 2021-present Alexis Bridoux.
// MIT license, see LICENSE file for details

import Foundation
import CoreData

// MARK: Basic predicate comparison

public func == <E: NSManagedObject, V: Equatable>(lhs: KeyPath<E, V>, rhs: V) -> Builders.BooleanPredicate<E, V, V> {
    .init(keyPath: lhs, operatorString: "==", value: rhs)
}

public func != <E: NSManagedObject, V: Equatable>(lhs: KeyPath<E, V>, rhs: V) -> Builders.BooleanPredicate<E, V, V> {
    .init(keyPath: lhs, operatorString: "!=", value: rhs)
}

public func > <E: NSManagedObject, V: Comparable>(lhs: KeyPath<E, V>, rhs: V) -> Builders.BooleanPredicate<E, V, V> {
    .init(keyPath: lhs, operatorString: ">", value: rhs)
}

public func >= <E: NSManagedObject, V: Comparable>(lhs: KeyPath<E, V>, rhs: V) -> Builders.BooleanPredicate<E, V, V> {
    .init(keyPath: lhs, operatorString: ">=", value: rhs)
}

public func < <E: NSManagedObject, V: Comparable>(lhs: KeyPath<E, V>, rhs: V) -> Builders.BooleanPredicate<E, V, V> {
    .init(keyPath: lhs, operatorString: "<", value: rhs)
}

public func <= <E: NSManagedObject, V: Comparable>(lhs: KeyPath<E, V>, rhs: V) -> Builders.BooleanPredicate<E, V, V> {
    .init(keyPath: lhs, operatorString: "<=", value: rhs)
}

