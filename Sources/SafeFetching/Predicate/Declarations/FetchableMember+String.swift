//
// SafeFetching
// Copyright © 2021-present Alexis Bridoux.
// MIT license, see LICENSE file for details

import CoreData

// MARK: - String Comparison

extension FetchableMember {

    public func hasPrefix(_ prefix: String, options: Builders.StringComparisonOptions? = nil) -> Builders.Predicate<Entity> {
        Builders.Predicate(
            identifier: identifier,
            operatorString: options.transformOperator("BEGINSWITH"),
            value: prefix
        )
    }

    public func hasSuffix(_ prefix: String, options: Builders.StringComparisonOptions? = nil) -> Builders.Predicate<Entity> {
        Builders.Predicate(
            identifier: identifier,
            operatorString: options.transformOperator("ENDSWITH"),
            value: prefix
        )
    }

    public func contains(_ prefix: String, options: Builders.StringComparisonOptions? = nil) -> Builders.Predicate<Entity> {
        Builders.Predicate(
            identifier: identifier,
            operatorString: options.transformOperator("CONTAINS"),
            value: prefix
        )
    }

    public func matches(_ prefix: String, options: Builders.StringComparisonOptions? = nil) -> Builders.Predicate<Entity> {
        Builders.Predicate(
            identifier: identifier,
            operatorString: options.transformOperator("MATCHES"),
            value: prefix
        )
    }
}
