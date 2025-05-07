//
// SafeFetching
// Copyright © 2021-present Alexis Bridoux.
// MIT license, see LICENSE file for details

import CoreData

// MARK: - From FetchableMember

extension FetchableMember where Value: Numeric & Comparable {

    public func isIn(_ range: ClosedRange<Value>) -> Builders.Predicate<Entity> {
        Builders.Predicate(
            identifier: identifier,
            operatorString: "BETWEEN",
            value: range
        )
    }

    public func isIn(_ range: Range<Value>) -> Builders.Predicate<Entity> {
        let format = "\(range.lowerBound) <= \(identifier) AND \(identifier) < \(range.upperBound)"
        return Builders.Predicate<Entity>(nsValue: NSPredicate(format: format))
    }
}

// MARK: - From ClosedRange

extension ClosedRange where Bound: DatabaseValue & DatabaseTestValue & Numeric {

    @_spi(SafeFetching)
    public func contains<Entity: Fetchable>(_ fetchableMember: FetchableMember<Entity, Bound>) -> Builders.Predicate<Entity> {
        fetchableMember.isIn(self)
    }
}

// MARK: - From Range

extension Range where Bound: DatabaseValue & DatabaseTestValue & Numeric {

    @_spi(SafeFetching)
    public func contains<Entity: Fetchable>(_ fetchableMember: FetchableMember<Entity, Bound>) -> Builders.Predicate<Entity> {
        fetchableMember.isIn(self)
    }
}
