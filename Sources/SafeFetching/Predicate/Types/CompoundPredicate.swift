//
// SafeFetching
// Copyright © 2021-present Alexis Bridoux.
// MIT license, see LICENSE file for details

import CoreData

// MARK: - CompoundPredicate

extension Builders {

    public final class CompoundPredicate<Entity: Fetchable>: Predicate<Entity> where Entity: NSManagedObject {

        init(joinOperator: JoinOperator, leftPredicate: Predicate<Entity>, rightPredicate: Predicate<Entity>) {
            let nsValue: NSPredicate

            switch joinOperator {
            case .and:
                nsValue = NSCompoundPredicate(andPredicateWithSubpredicates: [leftPredicate, rightPredicate].map(\.nsValue))
            case .or:
                nsValue = NSCompoundPredicate(orPredicateWithSubpredicates: [leftPredicate, rightPredicate].map(\.nsValue))
            }

            super.init(nsValue: nsValue)
        }
    }
}

// MARK: - JoinOperator

extension Builders {

    enum JoinOperator {
        case and, or
    }
}

// MARK: - Predicate <-> Predicate

public func && <E: NSManagedObject>(
    lhs: Builders.Predicate<E>,
    rhs: Builders.Predicate<E>
) -> Builders.CompoundPredicate<E> {
    Builders.CompoundPredicate(
        joinOperator: .and,
        leftPredicate: lhs,
        rightPredicate: rhs
    )
}

public func || <E: NSManagedObject>(
    lhs: Builders.Predicate<E>,
    rhs: Builders.Predicate<E>
) -> Builders.CompoundPredicate<E> {
    Builders.CompoundPredicate(
        joinOperator: .or,
        leftPredicate: lhs,
        rightPredicate: rhs
    )
}

// MARK: - KeyPath <-> Predicate

public func && <E: NSManagedObject>(
    lhs: KeyPath<E, Bool>,
    rhs: Builders.Predicate<E>
) -> Builders.CompoundPredicate<E> {
    Builders.CompoundPredicate(
        joinOperator: .and,
        leftPredicate: .init(keyPath: lhs),
        rightPredicate: rhs
    )
}

public func || <E: NSManagedObject>(
    lhs: KeyPath<E, Bool>,
    rhs: Builders.Predicate<E>
) -> Builders.CompoundPredicate<E> {
    Builders.CompoundPredicate(
        joinOperator: .or,
        leftPredicate: .init(keyPath: lhs),
        rightPredicate: rhs
    )
}

// MARK: - Predicate <-> KeyPath

public func && <E: NSManagedObject>(
    lhs: Builders.Predicate<E>,
    rhs: KeyPath<E, Bool>
) -> Builders.CompoundPredicate<E> {
    Builders.CompoundPredicate(
        joinOperator: .and,
        leftPredicate: lhs,
        rightPredicate: .init(keyPath: rhs)
    )
}

public func || <E: NSManagedObject>(
    lhs: Builders.Predicate<E>,
    rhs: KeyPath<E, Bool>
) -> Builders.CompoundPredicate<E> {
    Builders.CompoundPredicate(
        joinOperator: .or,
        leftPredicate: lhs,
        rightPredicate: .init(keyPath: rhs)
    )
}
