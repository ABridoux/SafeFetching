//
// SafeFetching
// Copyright © 2021-present Alexis Bridoux.
// MIT license, see LICENSE file for details

import CoreData

// MARK: - DatabaseValue

public func == <E: NSManagedObject, V: Equatable & DatabaseTestValue>(
    lhs: StringKeyPath<E, V>,
    rhs: V
) -> Builders.Predicate<E> {
    .init(keyPathString: lhs.key, operatorString: "==", value: rhs)
}

public func != <E: NSManagedObject, V: Equatable & DatabaseTestValue>(
    lhs: StringKeyPath<E, V>,
    rhs: V
) -> Builders.Predicate<E> {
    .init(keyPathString: lhs.key, operatorString: "!=", value: rhs)
}

public func > <E: NSManagedObject, V: Comparable & DatabaseTestValue>(
    lhs: StringKeyPath<E, V>,
    rhs: V
) -> Builders.Predicate<E> {
    .init(keyPathString: lhs.key, operatorString: ">", value: rhs)
}

public func >= <E: NSManagedObject, V: Comparable & DatabaseTestValue>(
    lhs: StringKeyPath<E, V>,
    rhs: V
) -> Builders.Predicate<E> {
    .init(keyPathString: lhs.key, operatorString: ">=", value: rhs)
}

public func < <E: NSManagedObject, V: Comparable & DatabaseTestValue>(
    lhs: StringKeyPath<E, V>,
    rhs: V
) -> Builders.Predicate<E>{
    .init(keyPathString: lhs.key, operatorString: "<", value: rhs)
}

public func <= <E: NSManagedObject, V: Comparable & DatabaseTestValue>(
    lhs: StringKeyPath<E, V>,
    rhs: V
) -> Builders.Predicate<E> {
    .init(keyPathString: lhs.key, operatorString: "<=", value: rhs)
}

public prefix func ! <E: NSManagedObject>(
    rhs: StringKeyPath<E, Bool>
) -> Builders.Predicate<E> {
    .init(keyPathString: rhs.key, isInverted: true)
}
