//
// SafeFetching
// Copyright © 2021-present Alexis Bridoux.
// MIT license, see LICENSE file for details

import CoreData

extension Builders {

    /// Wrapper around `NSPredicate` with a boolean test
    public struct BooleanPredicate<E: NSManagedObject, Value, TestValue> {

        // MARK: - Constants

        public typealias Formatter = (String) -> String
        public typealias ArgumentsOrder = (Any) -> [Any]
        typealias EntityKeyPath = KeyPath<E, Value>

        static var keyPathSymbol: String { "%K" }
        static var attributeSymbol: String { "%@" }

        // MARK: - Properties

        let value: TestValue
        let formatter: Formatter
        let argumentsOrder: ArgumentsOrder
        var keyPath: KeyPath<E, Value>

        public var nsValue: NSPredicate {
            let arguments = argumentsOrder(keyPath.label)
            let format = formatter(Self.keyPathSymbol)

            return NSPredicate(format: format, argumentArray: arguments)
        }

        // MARK: - Initialisation

        public init(keyPath: KeyPath<E, Value>, operatorString: String, value: TestValue, isInverted: Bool = false) {
            self.keyPath = keyPath
            self.value = value
            self.formatter = { "\(isInverted ? "NOT" : "") \($0) \(operatorString) \(Self.attributeSymbol)" }
            self.argumentsOrder = { [$0, value] }
        }

        public init(keyPath: KeyPath<E, Value>, value: TestValue, isInverted: Bool = false, formatter: @escaping Formatter, argumentsOrder: ArgumentsOrder? = nil) {
            self.keyPath = keyPath
            self.value = value
            self.formatter = formatter
            self.argumentsOrder = argumentsOrder ?? { [$0, value] }
        }
    }

}
