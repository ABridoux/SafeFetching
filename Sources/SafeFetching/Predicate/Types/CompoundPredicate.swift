//
// SafeFetching
// Copyright © 2021-present Alexis Bridoux.
// MIT license, see LICENSE file for details

import CoreData

// MARK: - CompoundPredicate

extension Builders {
    
    /// Predicate with `&&` (AND) or `||` (OR) operator to evaluate two predicates.
    public final class CompoundPredicate<LeftEntity: Fetchable, RightEntity: Fetchable>: Predicate<LeftEntity> where LeftEntity: NSManagedObject, RightEntity: NSManagedObject {

        init(joinOperator: JoinOperator, leftPredicate: Predicate<LeftEntity>, rightPredicate: Predicate<RightEntity>) {
            let nsValue: NSPredicate

            switch joinOperator {
            case .and:
                nsValue = NSCompoundPredicate(andPredicateWithSubpredicates: [leftPredicate.nsValue, rightPredicate.nsValue])
            case .or:
                nsValue = NSCompoundPredicate(orPredicateWithSubpredicates: [leftPredicate.nsValue, rightPredicate.nsValue])
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

public func && <LE: NSManagedObject, RE: NSManagedObject>(
    lhs: Builders.Predicate<LE>,
    rhs: Builders.Predicate<RE>
) -> Builders.CompoundPredicate<LE, RE> {
    Builders.CompoundPredicate(
        joinOperator: .and,
        leftPredicate: lhs,
        rightPredicate: rhs
    )
}

public func || <LE: NSManagedObject, RE: NSManagedObject>(
    lhs: Builders.Predicate<LE>,
    rhs: Builders.Predicate<RE>
) -> Builders.CompoundPredicate<LE, RE> {
    Builders.CompoundPredicate(
        joinOperator: .or,
        leftPredicate: lhs,
        rightPredicate: rhs
    )
}

// MARK: - KeyPath <-> Predicate

public func && <LE: NSManagedObject, RE: NSManagedObject>(
    lhs: FetchableMember<LE, Bool>,
    rhs: Builders.Predicate<RE>
) -> Builders.CompoundPredicate<LE, RE> {
    Builders.CompoundPredicate(
        joinOperator: .and,
        leftPredicate: Builders.Predicate<LE>(identifier: lhs.identifier),
        rightPredicate: rhs
    )
}

public func || <LE: NSManagedObject, RE: NSManagedObject>(
    lhs: FetchableMember<LE, Bool>,
    rhs: Builders.Predicate<RE>
) -> Builders.CompoundPredicate<LE, RE> {
    Builders.CompoundPredicate(
        joinOperator: .or,
        leftPredicate: Builders.Predicate<LE>(identifier: lhs.identifier),
        rightPredicate: rhs
    )
}

// MARK: - Predicate <-> KeyPath

public func && <LE: NSManagedObject, RE: NSManagedObject>(
    lhs: Builders.Predicate<LE>,
    rhs: FetchableMember<RE, Bool>
) -> Builders.CompoundPredicate<LE, RE> {
    Builders.CompoundPredicate(
        joinOperator: .and,
        leftPredicate: lhs,
        rightPredicate:  Builders.Predicate<RE>(identifier: rhs.identifier)
    )
}

public func || <LE: NSManagedObject, RE: NSManagedObject>(
    lhs: Builders.Predicate<LE>,
    rhs: FetchableMember<RE, Bool>
) -> Builders.CompoundPredicate<LE, RE> {
    Builders.CompoundPredicate(
        joinOperator: .or,
        leftPredicate: lhs,
        rightPredicate:  Builders.Predicate<RE>(identifier: rhs.identifier)
    )
}
