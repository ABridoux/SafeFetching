//
// SafeFetching
// Copyright © 2021-present Alexis Bridoux.
// MIT license, see LICENSE file for details

import Foundation

// MARK: - String

extension FetchableMember where Value == String {

    /// Returns a predicate to check whether the the attribute targeted by `self` is a match for the specified regular expression pattern.
    /// - Parameters:
    ///   - pattern: Pattern to match the attribute against.
    ///   - options: Options to change comparison behavior.
    public func matches(_ pattern: Builders.RegularExpressionPattern, options: Builders.StringComparisonOptions? = nil) -> Builders.Predicate<Entity> {
        Builders.Predicate(
            identifier: identifier,
            operatorString: options.transformOperator("MATCHES"),
            value: pattern.stringValue
        )
    }
}

// MARK: - String

extension FetchableMember where Value == String? {

    /// Returns a predicate to check whether the the attribute targeted by `self` is a match for the specified regular expression pattern.
    /// - Parameters:
    ///   - pattern: Pattern to match the attribute against.
    ///   - options: Options to change comparison behavior.
    public func matches(_ pattern: Builders.RegularExpressionPattern, options: Builders.StringComparisonOptions? = nil) -> Builders.Predicate<Entity> {
        Builders.Predicate(
            identifier: identifier,
            operatorString: options.transformOperator("MATCHES"),
            value: pattern.stringValue
        )
    }
}
