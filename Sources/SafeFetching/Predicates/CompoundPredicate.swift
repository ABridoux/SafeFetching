//
// SafeFetching
// Copyright © 2021-present Alexis Bridoux.
// MIT license, see LICENSE file for details

import CoreData

extension Builders {

    enum JoinOperator {
        case and, or
    }

    public struct CompoundPredicate<Entity, LeftValue, LeftTestValue, RightValue, RightTestValue>
    where Entity: NSManagedObject {

        let joinOperator: JoinOperator
        let leftPredicate: BooleanPredicate<Entity, LeftValue, LeftTestValue>
        let rightPredicate: BooleanPredicate<Entity, RightValue, RightTestValue>

        private var subNSValues: [NSPredicate] {
            [leftPredicate.nsValue, rightPredicate.nsValue]
        }

        public var nsValue: NSCompoundPredicate {
            switch joinOperator {
            case .and: return NSCompoundPredicate(andPredicateWithSubpredicates: subNSValues)
            case .or: return NSCompoundPredicate(orPredicateWithSubpredicates: subNSValues)
            }
        }
    }
}

public func && <E: NSManagedObject, LeftValue, LeftTestValue, RightValue, RightTestValue>(
    lhs: Builders.BooleanPredicate<E, LeftValue, LeftTestValue>,
    rhs: Builders.BooleanPredicate<E, RightValue, RightTestValue>
) -> Builders.CompoundPredicate<E, LeftValue, LeftTestValue, RightValue, RightTestValue> {
    Builders.CompoundPredicate(
        joinOperator: .and,
        leftPredicate: lhs,
        rightPredicate: rhs
    )
}
