//
// SafeFetching
// Copyright © 2021-present Alexis Bridoux.
// MIT license, see LICENSE file for details

public extension Builders.KeyPathPredicateRightValue where Value == String? {

    static func hasPrefix(_ prefix: String, options: Builders.StringComparisonOptions? = nil) -> Builders.KeyPathPredicateRightValue<Entity, Value, String> {
        .init { .init(keyPath: $0, operatorString: options.transformOperator("BEGINSWITH"), value: prefix) }
    }

    static func hasNoPrefix(_ prefix: String, options: Builders.StringComparisonOptions? = nil) -> Builders.KeyPathPredicateRightValue<Entity, Value, String> {
        .init { .init(keyPath: $0, operatorString: options.transformOperator("BEGINSWITH"), value: prefix, isInverted: true) }
    }

    static func hasSuffix(_ suffix: String, options: Builders.StringComparisonOptions? = nil) -> Builders.KeyPathPredicateRightValue<Entity, Value, String> {
        .init { .init(keyPath: $0, operatorString: options.transformOperator("ENDSWITH"), value: suffix) }
    }

    static func hasNoSuffix(_ suffix: String, options: Builders.StringComparisonOptions? = nil) -> Builders.KeyPathPredicateRightValue<Entity, Value, String> {
        .init { .init(keyPath: $0, operatorString: options.transformOperator("ENDSWITH"), value: suffix, isInverted: true) }
    }

    static func contains(_ other: String, options: Builders.StringComparisonOptions? = nil) -> Builders.KeyPathPredicateRightValue<Entity, Value, String> {
        .init { .init(keyPath: $0, operatorString: options.transformOperator("CONTAINS"), value: other) }
    }

    static func doesNotContain(_ other: String, options: Builders.StringComparisonOptions? = nil) -> Builders.KeyPathPredicateRightValue<Entity, Value, String> {
        .init { .init(keyPath: $0, operatorString: options.transformOperator("CONTAINS"), value: other, isInverted: true) }
    }

    static func matches(_ pattern: Builders.RegularExpressionPattern) -> Builders.KeyPathPredicateRightValue<Entity, Value, String> {
        .init { .init(keyPath: $0, operatorString: "MATCHES", value: pattern.stringValue) }
    }

    static func doesNotMatch(_ pattern: Builders.RegularExpressionPattern) -> Builders.KeyPathPredicateRightValue<Entity, Value, String> {
        .init { .init(keyPath: $0, operatorString: "MATCHES", value: pattern.stringValue, isInverted: true) }
    }
}

public extension Builders.KeyPathPredicateRightValue where Value == String {

    static func hasPrefix(_ prefix: String, options: Builders.StringComparisonOptions? = nil) -> Builders.KeyPathPredicateRightValue<Entity, Value, String> {
        .init { .init(keyPath: $0, operatorString: options.transformOperator("BEGINSWITH"), value: prefix) }
    }

    static func hasNoPrefix(_ prefix: String, options: Builders.StringComparisonOptions? = nil) -> Builders.KeyPathPredicateRightValue<Entity, Value, String> {
        .init { .init(keyPath: $0, operatorString: options.transformOperator("BEGINSWITH"), value: prefix, isInverted: true) }
    }

    static func hasSuffix(_ suffix: String, options: Builders.StringComparisonOptions? = nil) -> Builders.KeyPathPredicateRightValue<Entity, Value, String> {
        .init { .init(keyPath: $0, operatorString: options.transformOperator("ENDSWITH"), value: suffix) }
    }

    static func hasNoSuffix(_ suffix: String, options: Builders.StringComparisonOptions? = nil) -> Builders.KeyPathPredicateRightValue<Entity, Value, String> {
        .init { .init(keyPath: $0, operatorString: options.transformOperator("ENDSWITH"), value: suffix, isInverted: true) }
    }

    static func contains(_ other: String, options: Builders.StringComparisonOptions? = nil) -> Builders.KeyPathPredicateRightValue<Entity, Value, String> {
        .init { .init(keyPath: $0, operatorString: options.transformOperator("CONTAINS"), value: other) }
    }

    static func doesNotContain(_ other: String, options: Builders.StringComparisonOptions? = nil) -> Builders.KeyPathPredicateRightValue<Entity, Value, String> {
        .init { .init(keyPath: $0, operatorString: options.transformOperator("CONTAINS"), value: other, isInverted: true) }
    }

    static func matches(_ pattern: Builders.RegularExpressionPattern) -> Builders.KeyPathPredicateRightValue<Entity, Value, String> {
        .init { .init(keyPath: $0, operatorString: "MATCHES", value: pattern.stringValue) }
    }

    static func doesNotMatch(_ pattern: Builders.RegularExpressionPattern) -> Builders.KeyPathPredicateRightValue<Entity, Value, String> {
        .init { .init(keyPath: $0, operatorString: "MATCHES", value: pattern.stringValue, isInverted: true) }
    }
}
