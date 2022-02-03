//
// SafeFetching
// Copyright © 2021-present Alexis Bridoux.
// MIT license, see LICENSE file for details

public extension Builders.KeyPathPredicateRightValue where Value: Numeric & Comparable & DatabaseValue & DatabaseTestValue { 

    static func isIn(_ range: ClosedRange<Value>) -> Builders.KeyPathPredicateRightValue<Entity, Value, [Value]> {
        .init { keyPath in
            .init(keyPath: keyPath, operatorString: "BETWEEN", value: range)
        }
    }

    static func isNotIn(_ range: ClosedRange<Value>) -> Builders.KeyPathPredicateRightValue<Entity, Value, [Value]> {
        .init { keyPath in
            .init(keyPath: keyPath , operatorString: "BETWEEN", value: range, isInverted: true)
        }
    }

    static func isIn(_ range: Range<Value>) -> Builders.KeyPathPredicateRightValue<Entity, Value, [Value]> {
        .init { keyPath in
            .init(keyPath: keyPath) { "\(range.lowerBound) <= \($0) AND \($0) < \(range.upperBound)" }
        }
    }

    static func isNotIn(_ range: Range<Value>) -> Builders.KeyPathPredicateRightValue<Entity, Value, [Value]> {
        .init { keyPath in
            .init(keyPath: keyPath, isInverted: true) { "\($0) < \(range.lowerBound) OR \($0) >= \(range.upperBound)" }
        }
    }
}
