//
// SafeFetching
// Copyright © 2021-present Alexis Bridoux.
// MIT license, see LICENSE file for details

import CoreData

// MARK: - FetchableMember

public func == <E: NSManagedObject, V: Equatable & DatabaseValue & DatabaseTestValue>(
    lhs: FetchableMember<E, V>,
    rhs: V
) -> Builders.Predicate<E> {
    Builders.Predicate<E>(identifier: lhs.identifier, operatorString: "==", value: rhs)
}

public func != <E: NSManagedObject, V: Equatable & DatabaseValue & DatabaseTestValue>(
    lhs: FetchableMember<E, V>,
    rhs: V
) -> Builders.Predicate<E> {
    Builders.Predicate<E>(identifier: lhs.identifier, operatorString: "!=", value: rhs)
}

public func > <E: NSManagedObject, V: Comparable & DatabaseValue & DatabaseTestValue>(
    lhs: FetchableMember<E, V>,
    rhs: V
) -> Builders.Predicate<E> {
    Builders.Predicate<E>(identifier: lhs.identifier, operatorString: ">", value: rhs)
}

public func >= <E: NSManagedObject, V: Comparable & DatabaseValue & DatabaseTestValue>(
    lhs: FetchableMember<E, V>,
    rhs: V
) -> Builders.Predicate<E> {
    Builders.Predicate<E>(identifier: lhs.identifier, operatorString: ">=", value: rhs)
}

public func < <E: NSManagedObject, V: Comparable & DatabaseValue & DatabaseTestValue>(
    lhs: FetchableMember<E, V>,
    rhs: V
) -> Builders.Predicate<E> {
    Builders.Predicate<E>(identifier: lhs.identifier, operatorString: "<", value: rhs)
}

public func <= <E: NSManagedObject, V: Comparable & DatabaseValue & DatabaseTestValue>(
    lhs: FetchableMember<E, V>,
    rhs: V
) -> Builders.Predicate<E> {
    Builders.Predicate<E>(identifier: lhs.identifier, operatorString: "<=", value: rhs)
}

public prefix func ! <E: NSManagedObject>(rhs: FetchableMember<E, Bool>) -> Builders.Predicate<E> {
    Builders.Predicate<E>(identifier: rhs.identifier, isInverted: true)
}

// MARK: - Predicate

public prefix func ! <E: NSManagedObject>(rhs: Builders.Predicate<E>) -> Builders.Predicate<E> {
    rhs.inverted()
}

public func == <E: NSManagedObject>(
    lhs: Builders.Predicate<E>,
    rhs: Bool
) -> Builders.Predicate<E> {
    if rhs == false {
        return lhs.inverted()
    } else {
        return lhs
    }
}
