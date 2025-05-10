//
// SafeFetching
// Copyright © 2021-present Alexis Bridoux.
// MIT license, see LICENSE file for details

import CoreData

// MARK: - IsIN

extension FetchableMember where Value: DatabaseTestValue {

    /// Returns a predicate to check whether the attribute targeted by `self` is contained in the array.
    ///
    /// - Tip: Import SafeFetching with `@_spi(SafeFetching)` to use `Collection.contains(_:)`.
    public func isIn(_ values: [Value]) -> Builders.Predicate<Entity> {
        Builders.Predicate(
            identifier: identifier,
            operatorString: "IN",
            value: values
        )
    }

    /// Returns a predicate to check whether the attribute targeted by `self` is contained in the collection.
    ///
    /// - Tip: Import SafeFetching with `@_spi(SafeFetching)` to use `Collection.contains(_:)`.
    public func isIn(_ values: Value...) -> Builders.Predicate<Entity> {
        Builders.Predicate(
            identifier: identifier,
            operatorString: "IN",
            value: values
        )
    }

    /// Returns a predicate to check whether the attribute targeted by `self` is contained in the collection.
    ///
    /// - Tip: Import SafeFetching with `@_spi(SafeFetching)` to use `Collection.contains(_:)`.
    public func isIn(_ values: some Collection<Value>) -> Builders.Predicate<Entity> {
        Builders.Predicate(
            identifier: identifier,
            operatorString: "IN",
            value: Array(values)
        )
    }
}

// MARK: - Contains

extension Collection where Element: DatabaseValue & DatabaseTestValue {

    /// Returns a predicate to check whether the attribute targeted by `fetchableMember` is contained in the collection.
    @_spi(SafeFetching)
    public func contains<Entity: Fetchable>(
        _ fetchableMember: FetchableMember<Entity, Element>
    ) -> Builders.Predicate<Entity> {
        fetchableMember.isIn(self)
    }
}
