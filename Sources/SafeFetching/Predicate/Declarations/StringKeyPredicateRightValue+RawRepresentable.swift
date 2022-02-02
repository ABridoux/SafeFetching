//
// SafeFetching
// Copyright © 2021-present Alexis Bridoux.
// MIT license, see LICENSE file for details

//public extension Builders.StringKeyPathPredicateRightValue where Value: RawRepresentable, Value: DatabaseTestValue {
//
//    /// - important: Should be used only with raw representable types that are converted from/to a primitive value
//    ///
//    /// - note: For an option set, prefer the operation ``intersects(_:)-4pwbt``
//    static func isIn(_ array: [Value]) -> Builders.StringKeyPathPredicateRightValue<Entity, Value, [Value]> {
//        .init { .init(keyPathString: $0.key, operatorString: "IN", value: array.map(\.rawValue)) }
//    }
//
//    /// - important: Should be used only with raw representable types that are converted from/to a primitive value
//    ///
//    /// - note: For an option set, prefer the operation ``doesNotIntersect(_:)-5mwmt``
//    static func isNotIn(_ array: [Value]) -> Builders.StringKeyPathPredicateRightValue<Entity, Value, [Value]> {
//        .init { .init(keyPathString: $0.key, operatorString: "IN", value: array.map(\.rawValue), isInverted: true) }
//    }
//
//    /// - important: Should be used only with raw representable types that are converted from/to a primitive value
//    ///
//    /// - note: For an option set, prefer the operation ``intersects(_:)-4pwbt``
//    static func isIn(_ values: Value...) -> Builders.StringKeyPathPredicateRightValue<Entity, Value, [Value]> {
//        isIn(values)
//    }
//
//    /// - important: Should be used only with raw representable types that are converted from/to a primitive value
//    ///
//    /// - note: For an option set, prefer the operation ``doesNotIntersect(_:)-5mwmt``
//    static func isNotIn(_ values: Value...) -> Builders.StringKeyPathPredicateRightValue<Entity, Value, [Value]> {
//        isNotIn(values)
//    }
//}
//
//public extension Builders.StringKeyPathPredicateRightValue {
//
//    /// - important: Should be used only with raw representable types that are converted from/to a primitive value
//    ///
//    /// - note: For an option set, prefer the operation ``intersects(_:)-98s3b``
//    static func isIn<W: RawRepresentable>(_ array: [W]) -> Builders.StringKeyPathPredicateRightValue<Entity, Value, [Value]> where Value == W? {
//        .init { .init(keyPathString: $0.key, operatorString: "IN", value: array.map(\.rawValue)) }
//    }
//
//    /// - important: Should be used only with raw representable types that are converted from/to a primitive value
//    ///
//    /// - note: For an option set, prefer the operation ``doesNotIntersect(_:)-4abl9``
//    static func isNotIn<W: RawRepresentable>(_ array: [W]) -> Builders.StringKeyPathPredicateRightValue<Entity, Value, [Value]> where Value == W? {
//        .init { .init(keyPathString: $0.key, operatorString: "IN", value: array.map(\.rawValue), isInverted: true) }
//    }
//
//    /// - note: For an option set, prefer the operation ``intersects(_:)-98s3b``
//    static func isIn<W: RawRepresentable>(_ values: W...) -> Builders.StringKeyPathPredicateRightValue<Entity, Value, [Value]> where Value == W? {
//        isIn(values)
//    }
//
//    /// - important: Should be used only with raw representable types that are converted from/to a primitive value
//    ///
//    /// - note: For an option set, prefer the operation ``doesNotIntersect(_:)-4abl9``
//    static func isNotIn<W: RawRepresentable>(_ values: W...) -> Builders.StringKeyPathPredicateRightValue<Entity, Value, [Value]> where Value == W? {
//        .isNotIn(values)
//    }
//}
