//
// SafeFetching
// Copyright © 2021-present Alexis Bridoux.
// MIT license, see LICENSE file for details

import CoreData

/// A type that can be used in a predicate as a test value
///
/// - Default implementations are provided to ensure formatting.
/// - Implementation for `NSManagedObject`  is provided (for the relationships) and will use the [`objectID`](https://developer.apple.com/documentation/coredata/nsmanagedobject/1506848-objectid) property
public protocol DatabaseTestValue {

    /// Formatted string value that can be used in the format of a `NSPredicate`
    var testValue: String { get }
}

// MARK: - Scalar

extension String: DatabaseTestValue {

    public var testValue: String { #""\#(self)""# }
}

extension Int: DatabaseTestValue {

    public var testValue: String { String(describing: self) }
}

extension Int16: DatabaseTestValue {

    public var testValue: String { String(describing: self) }
}

extension Int32: DatabaseTestValue {

    public var testValue: String { String(describing: self) }
}

extension Int64: DatabaseTestValue {

    public var testValue: String { String(describing: self) }
}

extension Double: DatabaseTestValue {

    public var testValue: String { String(describing: self) }
}

extension Float: DatabaseTestValue {

    public var testValue: String { String(describing: self) }
}

extension Bool: DatabaseTestValue {
    public var testValue: String { String(describing: self) }
}

extension Date: DatabaseTestValue {
    public var testValue: String {
        #"CAST(\#(timeIntervalSinceReferenceDate), "NSDate")"#
    }
}

// MARK: - Optional

extension Optional: DatabaseTestValue where Wrapped: DatabaseTestValue {

    public var testValue: String {
        switch self {
        case .none: return "nil"
        case let .some(wrapped):
            return wrapped.testValue
        }
    }
}

extension NSManagedObject: DatabaseTestValue {

    public var testValue: String { String(describing: objectID) }
}

// MARK: - Array

extension Array: DatabaseTestValue where Element: DatabaseTestValue {

    public var testValue: String {
        "{ \(map(\.testValue).joined(separator: ","))}"
    }
}

// MARK: - RawRepresentable

extension DatabaseTestValue where Self: RawRepresentable, RawValue: DatabaseValue {

    public var testValue: String {
        if RawValue.self == String.self {
            return #""\#(rawValue)""#
        } else {
            return String(describing: rawValue)
        }
    }
}

// MARK: - Range

extension ClosedRange: DatabaseTestValue where Bound: Numeric {

    public var testValue: String {
        "{\(lowerBound), \(upperBound)}"
    }
}
