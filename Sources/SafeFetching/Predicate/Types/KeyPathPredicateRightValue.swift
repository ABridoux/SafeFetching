//
// SafeFetching
// Copyright © 2021-present Alexis Bridoux.
// MIT license, see LICENSE file for details

import CoreData

// MARK: - KeyPathPredicateRightValue

extension Builders {

    /// An operator and its right operand for a predicate, with no key path.
    public struct KeyPathPredicateRightValue<Entity: Fetchable, Value, TestValue> {

        // MARK: Type alias

        public typealias KeyPathPredicateExpression = (_ keyPath: KeyPath<Entity, Value>) -> Predicate<Entity>

        // MARK: Properties

        public let predicate: KeyPathPredicateExpression

        // MARK: Init

        public init(predicate: @escaping KeyPathPredicateExpression) {
            self.predicate = predicate
        }
    }
}

// MARK: - BooleanPredicate operator

public func * <Entity: Fetchable, Value, TestValue> (
    lhs: KeyPath<Entity, Value>,
    rhs: Builders.KeyPathPredicateRightValue<Entity, Value, TestValue>
) -> Builders.Predicate<Entity> {
    let nsValue = rhs.predicate(lhs).nsValue
    return Builders.Predicate<Entity>(nsValue: nsValue)
}
