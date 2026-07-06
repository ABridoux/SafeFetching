//
// SafeFetching
// Copyright © 2021-present Alexis Bridoux.
// MIT license, see LICENSE file for details

import CoreData

// MARK: - FetchableMember -> Value

public func == <E: Fetchable, V: Equatable & FetchableValue>(
    lhs: FetchableMember<E, V>,
    rhs: V
) -> Builders.Predicate<E> {
    Builders.Predicate<E>(identifier: lhs.identifier, operatorString: "==", value: rhs)
}

public func != <E: NSManagedObject, V: Equatable & FetchableValue>(
    lhs: FetchableMember<E, V>,
    rhs: V
) -> Builders.Predicate<E> {
    Builders.Predicate<E>(identifier: lhs.identifier, operatorString: "!=", value: rhs)
}

public func > <E: NSManagedObject, V: Comparable & FetchableValue>(
    lhs: FetchableMember<E, V>,
    rhs: V
) -> Builders.Predicate<E> {
    Builders.Predicate<E>(identifier: lhs.identifier, operatorString: ">", value: rhs)
}

public func >= <E: NSManagedObject, V: Comparable & FetchableValue>(
    lhs: FetchableMember<E, V>,
    rhs: V
) -> Builders.Predicate<E> {
    Builders.Predicate<E>(identifier: lhs.identifier, operatorString: ">=", value: rhs)
}

public func < <E: NSManagedObject, V: Comparable & FetchableValue>(
    lhs: FetchableMember<E, V>,
    rhs: V
) -> Builders.Predicate<E> {
    Builders.Predicate<E>(identifier: lhs.identifier, operatorString: "<", value: rhs)
}

public func <= <E: NSManagedObject, V: Comparable & FetchableValue>(
    lhs: FetchableMember<E, V>,
    rhs: V
) -> Builders.Predicate<E> {
    Builders.Predicate<E>(identifier: lhs.identifier, operatorString: "<=", value: rhs)
}

public prefix func ! <E: NSManagedObject>(rhs: FetchableMember<E, Bool>) -> Builders.Predicate<E> {
    Builders.Predicate<E>(identifier: rhs.identifier, isInverted: true)
}

// MARK: - FetchableMember -> FetchableMember

public func == <E: Fetchable, V: Equatable & FetchableValue, R: Fetchable>(
    lhs: FetchableMember<E, V>,
    rhs: FetchableMember<R, V>
) -> Builders.Predicate<E> {
    Builders.Predicate<E>(identifier: lhs.identifier, operatorString: "==", value: rhs)
}

public func != <E: Fetchable, V: Equatable & FetchableValue, R: Fetchable>(
    lhs: FetchableMember<E, V>,
    rhs: FetchableMember<R, V>
) -> Builders.Predicate<E> {
    Builders.Predicate<E>(identifier: lhs.identifier, operatorString: "!=", value: rhs)
}

public func > <E: NSManagedObject, V: Comparable & FetchableValue, R: Fetchable>(
    lhs: FetchableMember<E, V>,
    rhs: FetchableMember<R, V>
) -> Builders.Predicate<E> {
    Builders.Predicate<E>(identifier: lhs.identifier, operatorString: ">", value: rhs)
}

public func >= <E: NSManagedObject, V: Comparable & FetchableValue, R: Fetchable>(
    lhs: FetchableMember<E, V>,
    rhs: FetchableMember<R, V>
) -> Builders.Predicate<E> {
    Builders.Predicate<E>(identifier: lhs.identifier, operatorString: ">=", value: rhs)
}

public func < <E: NSManagedObject, V: Comparable & FetchableValue, R: Fetchable>(
    lhs: FetchableMember<E, V>,
    rhs: FetchableMember<R, V>
) -> Builders.Predicate<E> {
    Builders.Predicate<E>(identifier: lhs.identifier, operatorString: "<", value: rhs)
}

public func <= <E: NSManagedObject, V: Comparable & FetchableValue, R: Fetchable>(
    lhs: FetchableMember<E, V>,
    rhs: FetchableMember<R, V>
) -> Builders.Predicate<E> {
    Builders.Predicate<E>(identifier: lhs.identifier, operatorString: "<=", value: rhs)
}

// MARK: - FetchableMember -> NSManagedObject

public func == <E: Fetchable, V: NSManagedObject>(
    lhs: FetchableMember<E, V>,
    rhs: V
) -> Builders.Predicate<E> {
    Builders.Predicate<E>(identifier: lhs.identifier, operatorString: "==", managedObject: rhs)
}

public func == <E: Fetchable, V: NSManagedObject>(
    lhs: FetchableMember<E, V?>,
    rhs: V
) -> Builders.Predicate<E> {
    Builders.Predicate<E>(identifier: lhs.identifier, operatorString: "==", managedObject: rhs)
}

public func == <E: Fetchable, V: NSManagedObject>(
    lhs: FetchableMember<E, V>,
    rhs: NSManagedObjectID
) -> Builders.Predicate<E> {
    Builders.Predicate<E>(identifier: lhs.identifier, operatorString: "==", managedObjectID: rhs)
}

public func != <E: Fetchable, V: NSManagedObject>(
    lhs: FetchableMember<E, V>,
    rhs: V
) -> Builders.Predicate<E> {
    Builders.Predicate<E>(identifier: lhs.identifier, operatorString: "!=", managedObject: rhs)
}

public func != <E: Fetchable, V: NSManagedObject>(
    lhs: FetchableMember<E, V>,
    rhs: NSManagedObjectID
) -> Builders.Predicate<E> {
    Builders.Predicate<E>(identifier: lhs.identifier, operatorString: "!=", managedObjectID: rhs)
}

public func != <E: Fetchable, V: NSManagedObject>(
    lhs: FetchableMember<E, V?>,
    rhs: V
) -> Builders.Predicate<E> {
    Builders.Predicate<E>(identifier: lhs.identifier, operatorString: "!=", managedObject: rhs)
}

// MARK: - Boolean Predicate

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

// MARK: - FetchableMember -> Fetchable Members

public func == <E: Fetchable>(lhs: E.FetchableMembers, rhs: E) -> Builders.Predicate<E> {
    Builders.Predicate(
        identifier: "self",
        operatorString: "==",
        managedObject: rhs
    )
}

public func == <E: Fetchable>(lhs: E.FetchableMembers, rhs: NSManagedObjectID) -> Builders.Predicate<E> {
    Builders.Predicate(
        identifier: "self",
        operatorString: "==",
        managedObjectID: rhs
    )
}

public func != <E: Fetchable>(lhs: E.FetchableMembers, rhs: E) -> Builders.Predicate<E> {
    Builders.Predicate(
        identifier: "self",
        operatorString: "!=",
        managedObject: rhs
    )
}

public func != <E: Fetchable>(lhs: E.FetchableMembers, rhs: NSManagedObjectID) -> Builders.Predicate<E> {
    Builders.Predicate(
        identifier: "self",
        operatorString: "!=",
        managedObjectID: rhs
    )
}
