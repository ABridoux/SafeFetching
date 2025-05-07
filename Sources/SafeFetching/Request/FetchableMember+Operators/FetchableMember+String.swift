//
// SafeFetching
// Copyright © 2021-present Alexis Bridoux.
// MIT license, see LICENSE file for details

import CoreData

// MARK: - String Comparison

extension FetchableMember {

    /// Returns a predicate to check whether the the attribute targeted by `self` begins with the specified prefix.
    public func hasPrefix(_ prefix: String, options: Builders.StringComparisonOptions? = nil) -> Builders.Predicate<Entity> {
        Builders.Predicate(
            identifier: identifier,
            operatorString: options.transformOperator("BEGINSWITH"),
            value: prefix
        )
    }

    /// Returns a predicate to check whether the the attribute targeted by `self` ends with the specified suffix.
    public func hasSuffix(_ prefix: String, options: Builders.StringComparisonOptions? = nil) -> Builders.Predicate<Entity> {
        Builders.Predicate(
            identifier: identifier,
            operatorString: options.transformOperator("ENDSWITH"),
            value: prefix
        )
    }

    /// Returns a predicate to check whether the the attribute targeted by `self` contains the specified `other` string.
    public func contains(_ other: String, options: Builders.StringComparisonOptions? = nil) -> Builders.Predicate<Entity> {
        Builders.Predicate(
            identifier: identifier,
            operatorString: options.transformOperator("CONTAINS"),
            value: other
        )
    }

    /// Returns a predicate to check whether the the attribute targeted by `self` is a match for the specified regular expression pattern.
    public func matches(_ pattern: Builders.RegularExpressionPattern, options: Builders.StringComparisonOptions? = nil) -> Builders.Predicate<Entity> {
        Builders.Predicate(
            identifier: identifier,
            operatorString: options.transformOperator("MATCHES"),
            value: pattern.stringValue
        )
    }
}
