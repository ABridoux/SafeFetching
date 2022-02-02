//
// SafeFetching
// Copyright © 2021-present Alexis Bridoux.
// MIT license, see LICENSE file for details

public protocol DatabaseTestValue {

    var testValue: String { get }
}

extension String: DatabaseTestValue {

    public var testValue: String { self }
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

extension Optional: DatabaseTestValue where Wrapped: DatabaseTestValue {

    public var testValue: String {
        switch self {
        case .none: return "nil"
        case .some(let wrapped):
            return wrapped.testValue
        }
    }
}

extension Array: DatabaseTestValue where Element: DatabaseTestValue {

    public var testValue: String {
        "{ \(map(\.testValue).joined(separator: ","))}"
    }
}

extension DatabaseTestValue where Self: RawRepresentable, RawValue: DatabaseValue {

    public var testValue: String { String(describing: rawValue) }
}
