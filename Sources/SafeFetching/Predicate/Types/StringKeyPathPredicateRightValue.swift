//
// SafeFetching
// Copyright © 2021-present Alexis Bridoux.
// MIT license, see LICENSE file for details

import CoreData

extension Builders {

    /// An operator and its right operand for a predicate, with no key path.
    ///
    /// The provided key path is a ``StringKeyPath`` here
    public struct StringKeyPathPredicateRightValue<Entity: NSManagedObject, Value, TestValue> {
        public typealias StringKeyPathPredicateExpression = (StringKeyPath<Entity, Value>) -> Predicate<Entity>

        public let predicate: StringKeyPathPredicateExpression

        public init(predicate: @escaping StringKeyPathPredicateExpression) {
            self.predicate = predicate
        }
    }
}

// MARK: - BooleanPredicate operator

public func * <Entity: NSManagedObject, Value, TestValue> (
    lhs: StringKeyPath<Entity, Value>,
    rhs: Builders.StringKeyPathPredicateRightValue<Entity, Value, TestValue>
) -> Builders.Predicate<Entity> {

    let nsValue = rhs.predicate(lhs).nsValue
    return Builders.Predicate<Entity>(nsValue: nsValue)
}
