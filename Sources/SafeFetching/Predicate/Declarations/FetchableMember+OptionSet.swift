//
// SafeFetching
// Copyright © 2021-present Alexis Bridoux.
// MIT license, see LICENSE file for details

import CoreData

// MARK: - From FetchableMember

extension FetchableMember {

    public func intersects(_ value: Value) -> Builders.Predicate<Entity> {
        Builders.Predicate(
            identifier: identifier,
            operatorString: "& \(value.testValue) ==",
            value: value
        )
    }
}

// MARK: - From OptionSet

extension OptionSet where Self: DatabaseValue {

    public func intersects<Entity: Fetchable>(_ fetchableMember: FetchableMember<Entity, Self>) -> Builders.Predicate<Entity> {
        fetchableMember.intersects(self)
    }
}
