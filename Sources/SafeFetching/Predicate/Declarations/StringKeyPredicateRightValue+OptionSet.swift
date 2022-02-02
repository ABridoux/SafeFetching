//
// SafeFetching
// Copyright © 2021-present Alexis Bridoux.
// MIT license, see LICENSE file for details

public extension Builders.StringKeyPathPredicateRightValue where Value: OptionSet, Value.RawValue: BinaryInteger, Value: DatabaseTestValue {

    /// - important: Should be used only with options set types that are converted from/to a primitive value
    static func intersects(_ value: Value) -> Builders.StringKeyPathPredicateRightValue<Entity, Value, Value> {
        .init {
            .init(keyPathString: $0.key, value: value) { "\($0) & %@ == \($0)" }
        argumentsOrder: { [$0, value.rawValue, $0] }
        }
    }

    /// - important: Should be used only with options set types that are converted from/to a primitive value
    static func doesNotIntersect(_ value: Value) -> Builders.StringKeyPathPredicateRightValue<Entity, Value, Value> {
        .init {
            .init(keyPathString: $0.key, value: value) { "\($0) & %@ != \($0)" }
            argumentsOrder: { [$0, value.rawValue, $0] }
        }
    }
}

public extension Builders.StringKeyPathPredicateRightValue {

    /// - important: Should be used only with options set types that are converted from/to a primitive value
    static func intersects<W: OptionSet & DatabaseTestValue>(_ value: W) -> Builders.StringKeyPathPredicateRightValue<Entity, Value, Value>
    where Value == W?, W.RawValue: BinaryInteger {
        .init {
            .init(keyPathString: $0.key, value: value) { "\($0) & %@ == \($0)" }
        argumentsOrder: { [$0, value.rawValue, $0] }
        }
    }

    /// - important: Should be used only with options set types that are converted from/to a primitive value
    static func doesNotIntersect<W: OptionSet & DatabaseTestValue>(_ value: W) -> Builders.StringKeyPathPredicateRightValue<Entity, Value, Value>
    where Value == W?, W.RawValue: BinaryInteger {
        .init {
            .init(keyPathString: $0.key, value: value) { "\($0) & %@ != \($0)" }
        argumentsOrder: { [$0, value.rawValue, $0] }
        }
    }
}
