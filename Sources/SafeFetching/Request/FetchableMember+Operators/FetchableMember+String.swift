//
// SafeFetching
// Copyright © 2021-present Alexis Bridoux.
// MIT license, see LICENSE file for details

import CoreData

// MARK: - String

extension FetchableMember where Value == String {

    /// Returns a predicate to check whether the the attribute targeted by `self` begins with the specified prefix.
    /// - Parameters:
    ///   - prefix: A possible prefix to test against this string.
    ///   - options: Options to change comparison behavior.
    public func hasPrefix(_ prefix: String, options: Builders.StringComparisonOptions? = nil) -> Builders.Predicate<Entity> {
        Builders.Predicate(
            identifier: identifier,
            operatorString: options.transformOperator("BEGINSWITH"),
            value: prefix
        )
    }

    /// Returns a predicate to check whether the the attribute targeted by `self` ends with the specified suffix.
    /// - Parameters:
    ///   - prefix: A possible suffix to test against this string.
    ///   - options: Options to change comparison behavior.
    public func hasSuffix(_ prefix: String, options: Builders.StringComparisonOptions? = nil) -> Builders.Predicate<Entity> {
        Builders.Predicate(
            identifier: identifier,
            operatorString: options.transformOperator("ENDSWITH"),
            value: prefix
        )
    }

    /// Returns a predicate to check whether the the attribute targeted by `self` contains the specified `other` string.
    /// - Parameters:
    ///   - other: A possible string that is contained in the attribute.
    ///   - options: Options to change comparison behavior.
    public func contains(_ other: String, options: Builders.StringComparisonOptions? = nil) -> Builders.Predicate<Entity> {
        Builders.Predicate(
            identifier: identifier,
            operatorString: options.transformOperator("CONTAINS"),
            value: other
        )
    }
}

// MARK: - String?

extension FetchableMember where Value == String? {

    /// Returns a predicate to check whether the the attribute targeted by `self` begins with the specified prefix.
    /// - Parameters:
    ///   - prefix: A possible prefix to test against this string.
    ///   - options: Options to change comparison behavior.
    public func hasPrefix(_ prefix: String, options: Builders.StringComparisonOptions? = nil) -> Builders.Predicate<Entity> {
        Builders.Predicate(
            identifier: identifier,
            operatorString: options.transformOperator("BEGINSWITH"),
            value: prefix
        )
    }

    /// Returns a predicate to check whether the the attribute targeted by `self` ends with the specified suffix.
    /// - Parameters:
    ///   - prefix: A possible suffix to test against this string.
    ///   - options: Options to change comparison behavior.
    public func hasSuffix(_ prefix: String, options: Builders.StringComparisonOptions? = nil) -> Builders.Predicate<Entity> {
        Builders.Predicate(
            identifier: identifier,
            operatorString: options.transformOperator("ENDSWITH"),
            value: prefix
        )
    }

    /// Returns a predicate to check whether the the attribute targeted by `self` contains the specified `other` string.
    /// - Parameters:
    ///   - other: A possible string that is contained in the attribute.
    ///   - options: Options to change comparison behavior.
    public func contains(_ other: String, options: Builders.StringComparisonOptions? = nil) -> Builders.Predicate<Entity> {
        Builders.Predicate(
            identifier: identifier,
            operatorString: options.transformOperator("CONTAINS"),
            value: other
        )
    }
}
