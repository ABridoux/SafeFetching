//
// SafeFetching
// Copyright © 2021-present Alexis Bridoux.
// MIT license, see LICENSE file for details

import Foundation

/// Stub type with internal init to ensure no conformance can be added outside of the package
public struct DatabaseValueIdentification<T> {
    init() {}
}

/// A value that can be used in a predicate when fetching a CoreData store
///
/// Used to constraint some fetch functions to use only a valid storable type
public protocol DatabaseValue {

    static var identification: DatabaseValueIdentification<Self> { get }
}

extension String: DatabaseValue {
    public static var identification = DatabaseValueIdentification<String>()
}

extension Int: DatabaseValue {
    public static var identification = DatabaseValueIdentification<Int>()
}

extension Int16: DatabaseValue {
    public static var identification = DatabaseValueIdentification<Int16>()
}

extension Int32: DatabaseValue {
    public static var identification = DatabaseValueIdentification<Int32>()
}

extension Int64: DatabaseValue {
    public static var identification = DatabaseValueIdentification<Int64>()
}

extension Float: DatabaseValue {
    public static var identification = DatabaseValueIdentification<Float>()
}

extension Double: DatabaseValue {
    public static var identification = DatabaseValueIdentification<Double>()
}

extension Bool: DatabaseValue {
    public static var identification = DatabaseValueIdentification<Bool>()
}

extension Date: DatabaseValue {
    public static var identification = DatabaseValueIdentification<Date>()
}

extension Data: DatabaseValue {
    public static var identification = DatabaseValueIdentification<Data>()
}

extension UUID: DatabaseValue {
    public static var identification = DatabaseValueIdentification<UUID>()
}

extension URL: DatabaseValue {
    public static var identification = DatabaseValueIdentification<URL>()
}

extension Optional: DatabaseValue where Wrapped: DatabaseValue {
    public static var identification: DatabaseValueIdentification<Wrapped?> {
        DatabaseValueIdentification<Wrapped?>()
    }
}
