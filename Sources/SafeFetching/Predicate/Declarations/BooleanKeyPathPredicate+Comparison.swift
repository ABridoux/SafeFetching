//
// SafeFetching
// Copyright © 2021-present Alexis Bridoux.
// MIT license, see LICENSE file for details

import CoreData

public func == <E: NSManagedObject, V: Equatable & DatabaseValue & DatabaseTestValue>(lhs: KeyPath<E, V>, rhs: V) -> Builders.Predicate<E> {
    .init(keyPath: lhs, operatorString: "==", value: rhs)
}

public func != <E: NSManagedObject, V: Equatable & DatabaseValue & DatabaseTestValue>(lhs: KeyPath<E, V>, rhs: V) -> Builders.Predicate<E> {
    .init(keyPath: lhs, operatorString: "!=", value: rhs)
}

public func > <E: NSManagedObject, V: Comparable & DatabaseValue & DatabaseTestValue>(lhs: KeyPath<E, V>, rhs: V) -> Builders.Predicate<E> {
    .init(keyPath: lhs, operatorString: ">", value: rhs)
}

public func >= <E: NSManagedObject, V: Comparable & DatabaseValue & DatabaseTestValue>(lhs: KeyPath<E, V>, rhs: V) -> Builders.Predicate<E> {
    .init(keyPath: lhs, operatorString: ">=", value: rhs)
}

public func < <E: NSManagedObject, V: Comparable & DatabaseValue & DatabaseTestValue>(lhs: KeyPath<E, V>, rhs: V) -> Builders.Predicate<E> {
    .init(keyPath: lhs, operatorString: "<", value: rhs)
}

public func <= <E: NSManagedObject, V: Comparable & DatabaseValue & DatabaseTestValue>(lhs: KeyPath<E, V>, rhs: V) -> Builders.Predicate<E> {
    .init(keyPath: lhs, operatorString: "<=", value: rhs)
}
