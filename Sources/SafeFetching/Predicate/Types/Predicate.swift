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

    public convenience init<Value: FetchableValue>(
        identifier: String,
        operatorString: String,
        value: Value,
        isInverted: Bool = false
    ) {
        let format = "\(isInverted ? Self.inversionKeyword : "") \(identifier) \(operatorString) \(value.predicateRepresentation)"
        self.init(nsValue: NSPredicate(format: format))
    }

    public convenience init<ManagedObject: NSManagedObject>(
        identifier: String,
        operatorString: String,
        managedObject: ManagedObject,
        isInverted: Bool = false
    ) {
        self.init(nsValue: NSPredicate(format: "\(identifier) \(operatorString) %@", managedObject.objectID))
    }

    public convenience init(
        identifier: String,
        operatorString: String,
        managedObjectID: NSManagedObjectID,
        isInverted: Bool = false
    ) {
        self.init(nsValue: NSPredicate(format: "\(identifier) \(operatorString) %@", managedObjectID))
    }

    public static func predicate(_ predicate: (Entity.FetchableMembers) -> Builders.Predicate<Entity>) -> Builders.Predicate<Entity> {
        predicate(Entity.fetchableMembers)
    }

    public static func predicate<TargetEntity: Fetchable>(
        _ predicate: (Entity.FetchableMembers) -> FetchableMember<TargetEntity, Bool>
    ) -> Builders.Predicate<TargetEntity> {
        let fetchableMember = predicate(Entity.fetchableMembers)
        return Builders.Predicate<TargetEntity>(identifier: fetchableMember.identifier, operatorString: "==", value: true)
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
