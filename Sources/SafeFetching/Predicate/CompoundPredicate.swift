//
// SafeFetching
// Copyright © 2021-present Alexis Bridoux.
// MIT license, see LICENSE file for details

import CoreData

extension Builders {

    enum JoinOperator {
        case and, or
    }

    public final class CompoundPredicate<Entity>: Predicate<Entity> where Entity: NSManagedObject {

        init(joinOperator: JoinOperator, leftPredicate: Predicate<Entity>, rightPredicate: Predicate<Entity>) {
            let nsValue: NSPredicate

            switch joinOperator {
            case .and:
                nsValue = NSCompoundPredicate(andPredicateWithSubpredicates: [leftPredicate, rightPredicate].map(\.nsValue))
            case .or:
                nsValue = NSCompoundPredicate(orPredicateWithSubpredicates: [leftPredicate, rightPredicate].map(\.nsValue))
            }

            super.init(predicate: nsValue)
        }
    }
}

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
