//
// SafeFetching
// Copyright © 2021-present Alexis Bridoux.
// MIT license, see LICENSE file for details

import CoreData

extension Builders {

    public class Predicate<Entity: NSManagedObject> {

        public typealias Formatter = (String) -> String
        public typealias ArgumentsOrder = (Any) -> [Any]

        static var keyPathSymbol: String { "%K" }
        static var attributeSymbol: String { "%@" }

        public let nsValue: NSPredicate

        init(nsValue: NSPredicate) {
            self.nsValue = nsValue
        }
    }
}

// MARK: - KeyPath init

extension Builders.Predicate {

    public convenience init<Value, TestValue>(
        keyPath: KeyPath<Entity, Value>,
        operatorString: String,
        value: TestValue,
        isInverted: Bool = false
    ) {
        let value = value
        let formatter: Formatter = { "\(isInverted ? "NOT" : "") \($0) \(operatorString) \(Self.attributeSymbol)" }
        let argumentsOrder: ArgumentsOrder = { [$0, value] }

        let arguments = argumentsOrder(keyPath.label)
        let format = formatter(Self.keyPathSymbol)

        self.init(nsValue: NSPredicate(format: format, argumentArray: arguments))
    }

    public convenience init<Value, TestValue>(
        keyPath: KeyPath<Entity, Value>,
        value: TestValue, isInverted: Bool = false,
        formatter: @escaping Formatter,
        argumentsOrder: ArgumentsOrder? = nil
    ) {
        let value = value
        let formatter = formatter
        let argumentsOrder = argumentsOrder ?? { [$0, value] }

        let arguments = argumentsOrder(keyPath.label)
        let format = formatter(Self.keyPathSymbol)

        self.init(nsValue: NSPredicate(format: format, argumentArray: arguments))
    }
}

// MARK: - KeyPath string init

extension Builders.Predicate {

    public convenience init<TestValue>(
        keyPathString: String,
        operatorString: String,
        value: TestValue,
        isInverted: Bool = false
    ) {
        let value = value
        let formatter: Formatter = { "\(isInverted ? "NOT" : "") \($0) \(operatorString) \(Self.attributeSymbol)" }
        let argumentsOrder: ArgumentsOrder = { [$0, value] }

        let arguments = argumentsOrder(keyPathString)
        let format = formatter(Self.keyPathSymbol)

        self.init(nsValue: NSPredicate(format: format, argumentArray: arguments))
    }

    public convenience init<TestValue>(
        keyPathString: String,
        value: TestValue, isInverted: Bool = false,
        formatter: @escaping Formatter,
        argumentsOrder: ArgumentsOrder? = nil
    ) {
        let value = value
        let formatter = formatter
        let argumentsOrder = argumentsOrder ?? { [$0, value] }

        let arguments = argumentsOrder(keyPathString)
        let format = formatter(Self.keyPathSymbol)

        self.init(nsValue: NSPredicate(format: format, argumentArray: arguments))
    }
}
