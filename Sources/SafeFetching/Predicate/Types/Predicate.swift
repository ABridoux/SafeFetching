//
// SafeFetching
// Copyright © 2021-present Alexis Bridoux.
// MIT license, see LICENSE file for details

import CoreData

// MARK: - Predicate

extension Builders {

    /// Generated from ``FetchableMember`` operations to wrap a `NSPredicate`.
    public class Predicate<Entity: Fetchable> {

        // MARK: Type alias

        public typealias Formatter = (_ keyPath: String) -> String

        // MARK: Constants

        private static var inversionKeyword: String { "NOT" }

        // MARK: Property

        public let nsValue: NSPredicate

        // MARK: Init

        init(nsValue: NSPredicate) {
            self.nsValue = nsValue
        }
    }
}

// MARK: - Convenience Inits

extension Builders.Predicate {

    public convenience init<TestValue: DatabaseTestValue>(
        identifier: String,
        operatorString: String,
        value: TestValue,
        isInverted: Bool = false
    ) {
        let format = "\(isInverted ? Self.inversionKeyword : "") \(identifier) \(operatorString) \(value.testValue)"
        self.init(nsValue: NSPredicate(format: format))
    }

    public convenience init<TestValue: NSManagedObject>(
        identifier: String,
        operatorString: String,
        value: TestValue,
        isInverted: Bool = false
    ) {
        self.init(nsValue: NSPredicate(format: "\(identifier) \(operatorString) %@", value.objectID))
    }

    public static func predicate(_ predicate: (Entity.FetchableMembers) -> Builders.Predicate<Entity>) -> Builders.Predicate<Entity> {
        predicate(Entity.fetchableMembers)
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

// MARK: - Inverse

extension Builders.Predicate {

    func inverted() -> Builders.Predicate<Entity> {
        let newFormat = if nsValue.predicateFormat.hasPrefix(Self.inversionKeyword) {
            String(nsValue.predicateFormat.dropFirst(Self.inversionKeyword.count))
        } else {
            "\(Self.inversionKeyword) \(nsValue.predicateFormat)"
        }
        return Builders.Predicate<Entity>(nsValue: NSPredicate(format: newFormat))
    }
}
