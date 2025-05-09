//
// SafeFetching
// Copyright © 2021-present Alexis Bridoux.
// MIT license, see LICENSE file for details

import CoreData

// MARK: - Safe

extension NSPredicate {

    /// Safely builds a predicate for a provided entity type.
    public static func safe<Entity: Fetchable>(_ predicate: Builders.Predicate<Entity>) -> NSPredicate {
        predicate.nsValue
    }

    /// Safely builds a predicate for a provided entity type.
    public static func safe<SourceEntity: Fetchable, TargetEntity: Fetchable>(
        on _: SourceEntity.Type,
        _ predicate: (SourceEntity.FetchableMembers) -> Builders.Predicate<TargetEntity>
    ) -> NSPredicate {
        let predicate = predicate(SourceEntity.fetchableMembers)
        return predicate.nsValue
    }

    /// Safely builds a predicate for a provided entity type.
    public static func safe<SourceEntity: Fetchable, TargetEntity: Fetchable>(
        on _: SourceEntity.Type,
        _ fetchableMember: (SourceEntity.FetchableMembers) -> FetchableMember<TargetEntity, Bool>
    ) -> NSPredicate {
        let fetchableMember = fetchableMember(SourceEntity.fetchableMembers)
        let predicate = Builders.Predicate<TargetEntity>(identifier: fetchableMember.identifier, operatorString: "==", value: true)
        return predicate.nsValue
    }
}
