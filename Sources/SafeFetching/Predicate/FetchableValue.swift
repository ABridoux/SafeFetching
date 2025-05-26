//
// SafeFetching
// Copyright © 2021-present Alexis Bridoux.
// MIT license, see LICENSE file for details

import Foundation
import CoreData

// MARK: - FetchableValue

/// A type that can be used for an attribute or relationship in a predicate when fetching a CoreData store.
public protocol FetchableValue {

    var predicateRepresentation: String { get }
}

// MARK: - String

extension String: FetchableValue {

    public var predicateRepresentation: String {
        var escapedCopy = ""
        for indice in indices {
            let character = self[indice]
            switch character {
            case #"\"#, #"""#: // escaping: \ and "
                escapedCopy.append(contentsOf: #"\\#(character)"#)
            default:
                escapedCopy.append(character)
            }
        }
        return #""\#(escapedCopy)""#
    }
}

// MARK: - Int16

extension Int16: FetchableValue {

    public var predicateRepresentation: String { String(describing: self) }
}

// MARK: - Int32

extension Int32: FetchableValue {

    public var predicateRepresentation: String { String(describing: self) }
}

// MARK: - Int64

extension Int64: FetchableValue {

    public var predicateRepresentation: String { String(describing: self) }
}

// MARK: - Float

extension Float: FetchableValue {

    public var predicateRepresentation: String { String(describing: self) }
}

// MARK: - Double

extension Double: FetchableValue {

    public var predicateRepresentation: String { String(describing: self) }
}

// MARK: - Bool

extension Bool: FetchableValue {

    public var predicateRepresentation: String { String(describing: self) }
}

// MARK: - Date

extension Date: FetchableValue {

    public var predicateRepresentation: String {
        #"CAST(\#(timeIntervalSinceReferenceDate), "NSDate")"#
    }
}

// MARK: - Data

extension Data: FetchableValue {

    public var predicateRepresentation: String { String(describing: self) }
}

// MARK: - UUID

extension UUID: FetchableValue {

    public var predicateRepresentation: String { String(describing: self) }
}

// MARK: - URL

extension URL: FetchableValue {

    public var predicateRepresentation: String { String(describing: self) }
}

// MARK: - RawRepresentable

extension FetchableValue where Self: RawRepresentable, RawValue: FetchableValue {

    public var predicateRepresentation: String {
        if RawValue.self == String.self {
            return #""\#(rawValue)""#
        } else {
            return String(describing: rawValue)
        }
    }
}

// MARK: - Array

extension Array: FetchableValue where Element: FetchableValue  {

    public var predicateRepresentation: String {
        "{ \(map { $0.predicateRepresentation }.joined(separator: ","))}"
    }
}

// MARK: - Set

extension Set: FetchableValue where Element: FetchableValue {

    public var predicateRepresentation: String {
        "{ \(map { $0.predicateRepresentation }.joined(separator: ","))}"
    }
}

// MARK: - NSManagedObjectID

extension NSManagedObjectID: FetchableValue {

    public var predicateRepresentation: String {
        String(describing: self)
    }
}

// MARK: - NSManagedObject

extension NSManagedObject: FetchableValue {

    public var predicateRepresentation: String {
        String(describing: objectID)
    }
}

// MARK: - NSSet

extension NSSet: FetchableValue {

    public var predicateRepresentation: String {
        String(describing: lazy.compactMap { $0 as? NSManagedObject }.map(\.objectID))
    }
}
// MARK: - NSOrderedSet

extension NSOrderedSet: FetchableValue {

    public var predicateRepresentation: String {
        String(describing: lazy.compactMap { $0 as? NSManagedObject }.map(\.objectID))
    }
}

// MARK: - Optional

extension Optional: FetchableValue where Wrapped: FetchableValue {

    public var predicateRepresentation: String {
        switch self {
        case .none: "nil"
        case let .some(wrapped):
            wrapped.predicateRepresentation
        }
    }
}

// MARK: - ClosedRange

extension ClosedRange: FetchableValue where Bound: Numeric {

    public var predicateRepresentation: String {
        "{\(lowerBound), \(upperBound)}"
    }
}

// MARK: - Range

extension Range: FetchableValue where Bound: Numeric {

    public var predicateRepresentation: String {
        // not used
        String(describing: self)
    }
}
