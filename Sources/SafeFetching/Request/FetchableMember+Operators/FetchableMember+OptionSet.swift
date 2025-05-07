//
// SafeFetching
// Copyright © 2021-present Alexis Bridoux.
// MIT license, see LICENSE file for details

import CoreData

// MARK: - From FetchableMember

extension FetchableMember where Value: DatabaseTestValue {

    /// Returns a predicate to check whether the provided `value` intersects with the attribute targeted by `self`.
    public func intersects(_ value: Value) -> Builders.Predicate<Entity> {
        Builders.Predicate(
            identifier: identifier,
            operatorString: "& \(value.testValue) ==",
            value: value
        )
    }
}

// MARK: - From OptionSet

extension OptionSet where Self: DatabaseTestValue {

    /// Returns a predicate to check whether the `fetchableMember` intersects `self`.
    @_spi(SafeFetching)
    public func intersects<Entity: Fetchable>(_ fetchableMember: FetchableMember<Entity, Self>) -> Builders.Predicate<Entity> {
        fetchableMember.intersects(self)
    }
}
