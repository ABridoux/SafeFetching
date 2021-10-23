//
// SafeFetching
// Copyright © 2021-present Alexis Bridoux.
// MIT license, see LICENSE file for details

import CoreData

extension Builders {

    /// An operator and its right operand for a predicate, with no key path.
    public struct BooleanPredicateRightValue<Entity: NSManagedObject, Value, TestValue> {
        public typealias PredicateExpression = (KeyPath<Entity, Value>) -> BooleanPredicate<Entity, Value, TestValue>

        public let predicate: PredicateExpression

        public init(predicate: @escaping PredicateExpression) {
            self.predicate = predicate
        }
    }
}

// MARK: - Values set

public extension Builders.BooleanPredicateRightValue where Value: Equatable {

    // MARK: Values set

    static func isIn(_ values: Value...) -> Builders.BooleanPredicateRightValue<Entity, Value, [Value]> {
        .init { .init(keyPath: $0, operatorString: "IN", value: values) }
    }

    static func isNotIn(_ values: Value...) -> Builders.BooleanPredicateRightValue<Entity, Value, [Value]> {
        .init { .init(keyPath: $0, operatorString: "IN", value: values, isInverted: true) }
    }

    static func isIn(_ values: [Value]) -> Builders.BooleanPredicateRightValue<Entity, Value, [Value]> {
        .init { .init(keyPath: $0, operatorString: "IN", value: values) }
    }

    static func isNotIn(_ values: [Value]) -> Builders.BooleanPredicateRightValue<Entity, Value, [Value]> {
        .init { .init(keyPath: $0, operatorString: "IN", value: values, isInverted: true) }
    }
}

// MARK: - Range

public extension Builders.BooleanPredicateRightValue where Value: Numeric & Comparable {

    static func isIn(_ range: ClosedRange<Value>) -> Builders.BooleanPredicateRightValue<Entity, Value, [Value]> {
        .init { .init(keyPath: $0, operatorString: "BETWEEN", value: [range.lowerBound, range.upperBound]) }
    }

    static func isNotIn(_ range: ClosedRange<Value>) -> Builders.BooleanPredicateRightValue<Entity, Value, [Value]> {
        .init { .init(keyPath: $0, operatorString: "BETWEEN", value: [range.lowerBound, range.upperBound], isInverted: true) }
    }

    static func isIn(_ range: Range<Value>) -> Builders.BooleanPredicateRightValue<Entity, Value, [Value]> {
        .init {
            .init(keyPath: $0, value: [range.lowerBound, range.upperBound]) { "%@ <= \($0) AND \($0) < %@" }
                argumentsOrder: { [range.lowerBound, $0, $0, range.upperBound] }
        }
    }

    static func isNotIn(_ range: Range<Value>) -> Builders.BooleanPredicateRightValue<Entity, Value, [Value]> {
        .init {
            .init(keyPath: $0, value: [range.lowerBound, range.upperBound]) { "%@ > \($0) OR \($0) >= %@" }
                argumentsOrder: { [range.lowerBound, $0, $0, range.upperBound] }
        }
    }
}

// MARK: - String

public extension Builders.BooleanPredicateRightValue where Value == String? {

    static func hasPrefix(_ prefix: String) -> Builders.BooleanPredicateRightValue<Entity, Value, String> {
        .init { .init(keyPath: $0, operatorString: "BEGINSWITH", value: prefix) }
    }

    static func hasNoPrefix(_ prefix: String) -> Builders.BooleanPredicateRightValue<Entity, Value, String> {
        .init { .init(keyPath: $0, operatorString: "BEGINSWITH", value: prefix, isInverted: true) }
    }

    static func hasSuffix(_ suffix: String) -> Builders.BooleanPredicateRightValue<Entity, Value, String> {
        .init { .init(keyPath: $0, operatorString: "ENDSWITH", value: suffix) }
    }

    static func hasNoSuffix(_ suffix: String) -> Builders.BooleanPredicateRightValue<Entity, Value, String> {
        .init { .init(keyPath: $0, operatorString: "ENDSWITH", value: suffix, isInverted: true) }
    }

    static func contains(_ other: String) -> Builders.BooleanPredicateRightValue<Entity, Value, String> {
        .init { .init(keyPath: $0, operatorString: "CONTAINS", value: other) }
    }

    static func doesNotContain(_ other: String) -> Builders.BooleanPredicateRightValue<Entity, Value, String> {
        .init { .init(keyPath: $0, operatorString: "CONTAINS", value: other, isInverted: true) }
    }

    static func matches(_ pattern: Builders.RegularExpressionPattern) -> Builders.BooleanPredicateRightValue<Entity, Value, String> {
        .init { .init(keyPath: $0, operatorString: "MATCHES", value: pattern.stringValue) }
    }

    static func doesNotMatch(_ pattern: Builders.RegularExpressionPattern) -> Builders.BooleanPredicateRightValue<Entity, Value, String> {
        .init { .init(keyPath: $0, operatorString: "MATCHES", value: pattern.stringValue, isInverted: true) }
    }
}


// MARK: - BooleanPredicate operator

public func * <Entity: NSManagedObject, Value, TestValue> (
    lhs: KeyPath<Entity, Value>,
    rhs: Builders.BooleanPredicateRightValue<Entity, Value, TestValue>
) -> Builders.BooleanPredicate<Entity, Value, TestValue> {

    let nsValue = rhs.predicate(lhs).nsValue
    return Builders.BooleanPredicate<Entity, Value, TestValue>(predicate: nsValue)
}
