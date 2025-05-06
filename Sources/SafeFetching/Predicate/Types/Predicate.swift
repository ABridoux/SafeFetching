//
// SafeFetching
// Copyright © 2021-present Alexis Bridoux.
// MIT license, see LICENSE file for details

import CoreData

// MARK: - Predicate

extension Builders {

    public class Predicate<Entity: Fetchable> {

        // MARK: Type alias

        public typealias Formatter = (_ keyPath: String) -> String

        // MARK: Property

        public let nsValue: NSPredicate

        // MARK: Init

        init(nsValue: NSPredicate) {
            self.nsValue = nsValue
        }
    }
}

// MARK: - KeyPath init

extension Builders.Predicate {

    public convenience init<TestValue: DatabaseTestValue>(
        identifier: String,
        operatorString: String,
        value: TestValue,
        isInverted: Bool = false
    ) {
        let format = "\(isInverted ? "NOT" : "") \(identifier) \(operatorString) \(value.testValue)"
        self.init(nsValue: NSPredicate(format: format))
    }

    public convenience init(
        identifier: String,
        isInverted: Bool = false,
        formatter: @escaping Formatter
    ) {
        let format = formatter(identifier)
        self.init(nsValue: NSPredicate(format: format))
    }

    public convenience init(
        identifier: String,
        isInverted: Bool = false
    ) {
        let testValue = isInverted ? "0" : "1"
        let format = "\(identifier) == \(testValue)"
        self.init(nsValue: NSPredicate(format: format))
    }
}

// MARK: - KeyPath string init

//extension Builders.Predicate {
//
//    public convenience init<TestValue: DatabaseTestValue>(
//        keyPathString: Substring,
//        operatorString: String,
//        value: TestValue,
//        isInverted: Bool = false
//    ) {
//        let format = "\(isInverted ? "NOT" : "") \(keyPathString) \(operatorString) \(value.testValue)"
//        self.init(nsValue: NSPredicate(format: format))
//    }
//
//    public convenience init(
//        keyPathString: Substring,
//        isInverted: Bool = false,
//        formatter: @escaping Formatter
//    ) {
//
//        let format = formatter(keyPathString)
//        self.init(nsValue: NSPredicate(format: format))
//    }
//
//    public convenience init(
//        keyPathString: Substring,
//        isInverted: Bool = false
//    ) {
//        let testValue = isInverted ? "0" : "1"
//        let format = "\(keyPathString) == \(testValue)"
//        self.init(nsValue: NSPredicate(format: format))
//    }
//}
