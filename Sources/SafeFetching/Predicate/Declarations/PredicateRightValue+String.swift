//
// SafeFetching
// Copyright © 2021-present Alexis Bridoux.
// MIT license, see LICENSE file for details

public extension Builders.PredicateRightValue where Value == String? {

    static func hasPrefix(_ prefix: String) -> Builders.PredicateRightValue<Entity, Value, String> {
        .init { .init(keyPath: $0, operatorString: "BEGINSWITH", value: prefix) }
    }

    static func hasNoPrefix(_ prefix: String) -> Builders.PredicateRightValue<Entity, Value, String> {
        .init { .init(keyPath: $0, operatorString: "BEGINSWITH", value: prefix, isInverted: true) }
    }

    static func hasSuffix(_ suffix: String) -> Builders.PredicateRightValue<Entity, Value, String> {
        .init { .init(keyPath: $0, operatorString: "ENDSWITH", value: suffix) }
    }

    static func hasNoSuffix(_ suffix: String) -> Builders.PredicateRightValue<Entity, Value, String> {
        .init { .init(keyPath: $0, operatorString: "ENDSWITH", value: suffix, isInverted: true) }
    }

    static func contains(_ other: String) -> Builders.PredicateRightValue<Entity, Value, String> {
        .init { .init(keyPath: $0, operatorString: "CONTAINS", value: other) }
    }

    static func doesNotContain(_ other: String) -> Builders.PredicateRightValue<Entity, Value, String> {
        .init { .init(keyPath: $0, operatorString: "CONTAINS", value: other, isInverted: true) }
    }

    static func matches(_ pattern: Builders.RegularExpressionPattern) -> Builders.PredicateRightValue<Entity, Value, String> {
        .init { .init(keyPath: $0, operatorString: "MATCHES", value: pattern.stringValue) }
    }

    static func doesNotMatch(_ pattern: Builders.RegularExpressionPattern) -> Builders.PredicateRightValue<Entity, Value, String> {
        .init { .init(keyPath: $0, operatorString: "MATCHES", value: pattern.stringValue, isInverted: true) }
    }
}

public extension Builders.PredicateRightValue where Value == String {

    static func hasPrefix(_ prefix: String) -> Builders.PredicateRightValue<Entity, Value, String> {
        .init { .init(keyPath: $0, operatorString: "BEGINSWITH", value: prefix) }
    }

    static func hasNoPrefix(_ prefix: String) -> Builders.PredicateRightValue<Entity, Value, String> {
        .init { .init(keyPath: $0, operatorString: "BEGINSWITH", value: prefix, isInverted: true) }
    }

    static func hasSuffix(_ suffix: String) -> Builders.PredicateRightValue<Entity, Value, String> {
        .init { .init(keyPath: $0, operatorString: "ENDSWITH", value: suffix) }
    }

    static func hasNoSuffix(_ suffix: String) -> Builders.PredicateRightValue<Entity, Value, String> {
        .init { .init(keyPath: $0, operatorString: "ENDSWITH", value: suffix, isInverted: true) }
    }

    static func contains(_ other: String) -> Builders.PredicateRightValue<Entity, Value, String> {
        .init { .init(keyPath: $0, operatorString: "CONTAINS", value: other) }
    }

    static func doesNotContain(_ other: String) -> Builders.PredicateRightValue<Entity, Value, String> {
        .init { .init(keyPath: $0, operatorString: "CONTAINS", value: other, isInverted: true) }
    }

    static func matches(_ pattern: Builders.RegularExpressionPattern) -> Builders.PredicateRightValue<Entity, Value, String> {
        .init { .init(keyPath: $0, operatorString: "MATCHES", value: pattern.stringValue) }
    }

    static func doesNotMatch(_ pattern: Builders.RegularExpressionPattern) -> Builders.PredicateRightValue<Entity, Value, String> {
        .init { .init(keyPath: $0, operatorString: "MATCHES", value: pattern.stringValue, isInverted: true) }
    }
}
