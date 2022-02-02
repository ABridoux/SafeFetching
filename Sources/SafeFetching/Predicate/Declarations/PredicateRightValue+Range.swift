//
// SafeFetching
// Copyright © 2021-present Alexis Bridoux.
// MIT license, see LICENSE file for details

public extension Builders.KeyPathPredicateRightValue where Value: Numeric & Comparable & DatabaseValue & DatabaseTestValue { 

    static func isIn(_ range: ClosedRange<Value>) -> Builders.KeyPathPredicateRightValue<Entity, Value, [Value]> {
        .init { .init(keyPath: $0, operatorString: "BETWEEN", value: [range.lowerBound, range.upperBound]) }
    }

    static func isNotIn(_ range: ClosedRange<Value>) -> Builders.KeyPathPredicateRightValue<Entity, Value, [Value]> {
        .init { .init(keyPath: $0, operatorString: "BETWEEN", value: [range.lowerBound, range.upperBound], isInverted: true) }
    }

    static func isIn(_ range: Range<Value>) -> Builders.KeyPathPredicateRightValue<Entity, Value, [Value]> {
        .init {
            .init(keyPath: $0, value: [range.lowerBound, range.upperBound]) { "%@ <= \($0) AND \($0) < %@" }
                argumentsOrder: { [range.lowerBound, $0, $0, range.upperBound] }
        }
    }

    static func isNotIn(_ range: Range<Value>) -> Builders.KeyPathPredicateRightValue<Entity, Value, [Value]> {
        .init {
            .init(keyPath: $0, value: [range.lowerBound, range.upperBound]) { "%@ > \($0) OR \($0) >= %@" }
                argumentsOrder: { [range.lowerBound, $0, $0, range.upperBound] }
        }
    }
}
