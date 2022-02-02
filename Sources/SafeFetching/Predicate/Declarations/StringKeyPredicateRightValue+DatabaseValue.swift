//
// SafeFetching
// Copyright © 2021-present Alexis Bridoux.
// MIT license, see LICENSE file for details

public extension Builders.StringKeyPathPredicateRightValue where Value: Equatable & DatabaseTestValue {

    /// - important: Should be used only with database values that are converted from/to a primitive value
    static func isIn(_ array: [Value]) -> Builders.StringKeyPathPredicateRightValue<Entity, Value, [Value]> {
        .init { .init(keyPathString: $0.key, operatorString: "IN", value: array) }
    }

    /// - important: Should be used only with database values that are converted from/to a primitive value
    static func isNotIn(_ array: [Value]) -> Builders.StringKeyPathPredicateRightValue<Entity, Value, [Value]> {
        .init { .init(keyPathString: $0.key, operatorString: "IN", value: array, isInverted: true) }
    }

    /// - important: Should be used only with database values that are converted from/to a primitive value
    static func isIn(_ values: Value...) -> Builders.StringKeyPathPredicateRightValue<Entity, Value, [Value]> {
        isIn(values)
    }

    /// - important: Should be used only with database values that are converted from/to a primitive value
    static func isNotIn(_ values: Value...) -> Builders.StringKeyPathPredicateRightValue<Entity, Value, [Value]> {
        isNotIn(values)
    }
}
