//
// SafeFetching
// Copyright © 2021-present Alexis Bridoux.
// MIT license, see LICENSE file for details

import Foundation
import CoreData

/// Stub type with internal init to ensure no conformance to ``DatabaseValue`` can be added outside of the package
public struct DatabaseValueIdentification {
    init() {}
}

/// A type that can be used for an attribute in a predicate when fetching a CoreData store
///
/// Used to constraint some fetch functions to use only a valid storable type
public protocol DatabaseValue {

    static var identification: DatabaseValueIdentification { get }
}

// MARK: Field

extension String: DatabaseValue {
    public static let identification = DatabaseValueIdentification()
}

extension Int: DatabaseValue {
    public static let identification = DatabaseValueIdentification()
}

extension Int16: DatabaseValue {
    public static let identification = DatabaseValueIdentification()
}

extension Int32: DatabaseValue {
    public static let identification = DatabaseValueIdentification()
}

extension Int64: DatabaseValue {
    public static let identification = DatabaseValueIdentification()
}

extension Float: DatabaseValue {
    public static let identification = DatabaseValueIdentification()
}

extension Double: DatabaseValue {
    public static let identification = DatabaseValueIdentification()
}

extension Bool: DatabaseValue {
    public static let identification = DatabaseValueIdentification()
}

extension Date: DatabaseValue {
    public static let identification = DatabaseValueIdentification()
}

extension Data: DatabaseValue {
    public static let identification = DatabaseValueIdentification()
}

extension UUID: DatabaseValue {
    public static let identification = DatabaseValueIdentification()
}

extension URL: DatabaseValue {
    public static let identification = DatabaseValueIdentification()
}

// MARK:  Relationship

extension Set: DatabaseValue where Element: NSManagedObject {
    public static var identification: DatabaseValueIdentification {
        DatabaseValueIdentification()
    }
}

extension NSSet: DatabaseValue {
    public static let identification = DatabaseValueIdentification()
}

extension NSOrderedSet: DatabaseValue {
    public static let identification = DatabaseValueIdentification()
}

// MARK: Optional

extension Optional: DatabaseValue where Wrapped: DatabaseValue {
    public static var identification: DatabaseValueIdentification {
        DatabaseValueIdentification()
    }
}
