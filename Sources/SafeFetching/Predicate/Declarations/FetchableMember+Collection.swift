//
// SafeFetching
// Copyright © 2021-present Alexis Bridoux.
// MIT license, see LICENSE file for details

import CoreData

// MARK: - IsIN

extension FetchableMember {

    public func isIn(_ values: [Value]) -> Builders.Predicate<Entity> {
        Builders.Predicate(
            identifier: identifier,
            operatorString: "IN",
            value: values
        )
    }

    public func isIn(_ values: Value...) -> Builders.Predicate<Entity> {
        Builders.Predicate(
            identifier: identifier,
            operatorString: "IN",
            value: values
        )
    }

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

    @_spi(SafeFetching)
    public func contains<Entity: Fetchable>(
        _ fetchableMember: FetchableMember<Entity, Element>
    ) -> Builders.Predicate<Entity> {
        fetchableMember.isIn(self)
    }
}
