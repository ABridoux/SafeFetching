//
// SafeFetching
// Copyright © 2021-present Alexis Bridoux.
// MIT license, see LICENSE file for details

import CoreData

// MARK: - DatabaseValue

public func == <E: NSManagedObject, V: DatabaseValue & Equatable>(
    lhs: StringKeyPath<E, V>,
    rhs: V
) -> Builders.Predicate<E> {
    .init(keyPathString: lhs.key, operatorString: "==", value: rhs)
}

public func != <E: NSManagedObject, V: DatabaseValue & Equatable>(
    lhs: StringKeyPath<E, V>,
    rhs: V
) -> Builders.Predicate<E> {
    .init(keyPathString: lhs.key, operatorString: "!=", value: rhs)
}

public func > <E: NSManagedObject, V: DatabaseValue & Comparable>(
    lhs: StringKeyPath<E, V>,
    rhs: V
) -> Builders.Predicate<E> {
    .init(keyPathString: lhs.key, operatorString: ">", value: rhs)
}

public func >= <E: NSManagedObject, V: DatabaseValue & Comparable>(
    lhs: StringKeyPath<E, V>,
    rhs: V
) -> Builders.Predicate<E> {
    .init(keyPathString: lhs.key, operatorString: ">=", value: rhs)
}

public func < <E: NSManagedObject, V: DatabaseValue & Comparable>(
    lhs: StringKeyPath<E, V>,
    rhs: V
) -> Builders.Predicate<E>{
    .init(keyPathString: lhs.key, operatorString: "<", value: rhs)
}

public func <= <E: NSManagedObject, V: DatabaseValue & Comparable>(
    lhs: StringKeyPath<E, V>,
    rhs: V
) -> Builders.Predicate<E> {
    .init(keyPathString: lhs.key, operatorString: "<=", value: rhs)
}

// MARK: - RawRepresentable

public func == <E: NSManagedObject, V: RawRepresentable & Equatable>(
    lhs: StringKeyPath<E, V>,
    rhs: V
) -> Builders.Predicate<E> {
    .init(keyPathString: lhs.key, operatorString: "==", value: rhs.rawValue)
}

public func != <E: NSManagedObject, V: RawRepresentable & Equatable>(
    lhs: StringKeyPath<E, V>,
    rhs: V
) -> Builders.Predicate<E> {
    .init(keyPathString: lhs.key, operatorString: "!=", value: rhs.rawValue)
}

public func > <E: NSManagedObject, V: RawRepresentable & Comparable>(
    lhs: StringKeyPath<E, V>,
    rhs: V
) -> Builders.Predicate<E> {
    .init(keyPathString: lhs.key, operatorString: ">", value: rhs.rawValue)
}

public func >= <E: NSManagedObject, V: RawRepresentable & Comparable>(
    lhs: StringKeyPath<E, V>,
    rhs: V
) -> Builders.Predicate<E> {
    .init(keyPathString: lhs.key, operatorString: ">=", value: rhs.rawValue)
}

public func < <E: NSManagedObject, V: RawRepresentable & Comparable>(
    lhs: StringKeyPath<E, V>,
    rhs: V
) -> Builders.Predicate<E>{
    .init(keyPathString: lhs.key, operatorString: "<", value: rhs.rawValue)
}

public func <= <E: NSManagedObject, V: RawRepresentable & Comparable>(
    lhs: StringKeyPath<E, V>,
    rhs: V
) -> Builders.Predicate<E> {
    .init(keyPathString: lhs.key, operatorString: "<=", value: rhs.rawValue)
}
