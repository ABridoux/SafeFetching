//
// SafeFetching
// Copyright © 2021-present Alexis Bridoux.
// MIT license, see LICENSE file for details

import CoreData

extension Builders {

    /// An operator and its right operand for a predicate, with no key path.
    public struct PredicateRightValue<Entity: NSManagedObject, Value, TestValue> {
        public typealias PredicateExpression = (KeyPath<Entity, Value>) -> Predicate<Entity>

        public let predicate: PredicateExpression

        public init(predicate: @escaping PredicateExpression) {
            self.predicate = predicate
        }
    }
}

// MARK: - Values set

public extension Builders.PredicateRightValue where Value: Equatable {

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

// MARK: - Range

public extension Builders.PredicateRightValue where Value: Numeric & Comparable {

    static func isIn(_ range: ClosedRange<Value>) -> Builders.PredicateRightValue<Entity, Value, [Value]> {
        .init { .init(keyPath: $0, operatorString: "BETWEEN", value: [range.lowerBound, range.upperBound]) }
    }

    static func isNotIn(_ range: ClosedRange<Value>) -> Builders.PredicateRightValue<Entity, Value, [Value]> {
        .init { .init(keyPath: $0, operatorString: "BETWEEN", value: [range.lowerBound, range.upperBound], isInverted: true) }
    }

    static func isIn(_ range: Range<Value>) -> Builders.PredicateRightValue<Entity, Value, [Value]> {
        .init {
            .init(keyPath: $0, value: [range.lowerBound, range.upperBound]) { "%@ <= \($0) AND \($0) < %@" }
                argumentsOrder: { [range.lowerBound, $0, $0, range.upperBound] }
        }
    }

    static func isNotIn(_ range: Range<Value>) -> Builders.PredicateRightValue<Entity, Value, [Value]> {
        .init {
            .init(keyPath: $0, value: [range.lowerBound, range.upperBound]) { "%@ > \($0) OR \($0) >= %@" }
                argumentsOrder: { [range.lowerBound, $0, $0, range.upperBound] }
        }
    }
}

// MARK: - String

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


// MARK: - BooleanPredicate operator

public func * <Entity: NSManagedObject, Value, TestValue> (
    lhs: KeyPath<Entity, Value>,
    rhs: Builders.PredicateRightValue<Entity, Value, TestValue>
) -> Builders.Predicate<Entity> {

    let nsValue = rhs.predicate(lhs).nsValue
    return Builders.Predicate<Entity>(predicate: nsValue)
}
