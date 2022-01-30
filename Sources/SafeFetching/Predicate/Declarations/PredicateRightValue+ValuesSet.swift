//
// SafeFetching
// Copyright © 2021-present Alexis Bridoux.
// MIT license, see LICENSE file for details

public extension Builders.PredicateRightValue where Value: Equatable & DatabaseValue {

    // MARK: Values set

    static func isIn(_ values: Value...) -> Builders.PredicateRightValue<Entity, Value, [Value]> {
        .init { .init(keyPath: $0, operatorString: "IN", value: values) }
    }

    static func isNotIn(_ values: Value...) -> Builders.PredicateRightValue<Entity, Value, [Value]> {
        .init { .init(keyPath: $0, operatorString: "IN", value: values, isInverted: true) }
    }

    static func isIn(_ values: [Value]) -> Builders.PredicateRightValue<Entity, Value, [Value]> {
        .init { .init(keyPath: $0, operatorString: "IN", value: values) }
    }

    static func isNotIn(_ values: [Value]) -> Builders.PredicateRightValue<Entity, Value, [Value]> {
        .init { .init(keyPath: $0, operatorString: "IN", value: values, isInverted: true) }
    }
}

