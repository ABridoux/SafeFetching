//
// SafeFetching
// Copyright © 2021-present Alexis Bridoux.
// MIT license, see LICENSE file for details

import CoreData

extension Builders {

    public class Predicate<Entity: Fetchable> {

        public typealias Formatter = (_ keyPath: Substring) -> String

        public let nsValue: NSPredicate

        init(nsValue: NSPredicate) {
            self.nsValue = nsValue
        }
    }
}

// MARK: - KeyPath init

extension Builders.Predicate {

    public convenience init<Value, TestValue: DatabaseTestValue>(
        keyPath: KeyPath<Entity, Value>,
        operatorString: String,
        value: TestValue,
        isInverted: Bool = false
    ) {
        let format = "\(isInverted ? "NOT" : "") \(keyPath.label) \(operatorString) \(value.testValue)"
        self.init(nsValue: NSPredicate(format: format))
    }

    public convenience init<Value>(
        keyPath: KeyPath<Entity, Value>,
        isInverted: Bool = false,
        formatter: @escaping Formatter
    ) {
        let format = formatter(keyPath.label)
        self.init(nsValue: NSPredicate(format: format))
    }

    public convenience init(
        keyPath: KeyPath<Entity, Bool>,
        isInverted: Bool = false
    ) {
        let testValue = isInverted ? "0" : "1"
        let format = "\(keyPath.label) == \(testValue)"
        self.init(nsValue: NSPredicate(format: format))
    }
}

// MARK: - KeyPath string init

extension Builders.Predicate {

    public convenience init<TestValue: DatabaseTestValue>(
        keyPathString: Substring,
        operatorString: String,
        value: TestValue,
        isInverted: Bool = false
    ) {
        let format = "\(isInverted ? "NOT" : "") \(keyPathString) \(operatorString) \(value.testValue)"
        self.init(nsValue: NSPredicate(format: format))
    }

    public convenience init(
        keyPathString: Substring,
        isInverted: Bool = false,
        formatter: @escaping Formatter
    ) {

        let format = formatter(keyPathString)
        self.init(nsValue: NSPredicate(format: format))
    }

    public convenience init(
        keyPathString: Substring,
        isInverted: Bool = false
    ) {
        let testValue = isInverted ? "0" : "1"
        let format = "\(keyPathString) == \(testValue)"
        self.init(nsValue: NSPredicate(format: format))
    }
}
