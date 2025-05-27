//
// SafeFetching
// Copyright © 2021-present Alexis Bridoux.
// MIT license, see LICENSE file for details

import CoreData

// MARK: - Safe

extension NSPredicate {

    /// Returns a `NSPredicate` built from a SafeFetching predicate.
    /// - Parameter predicate: A predicate which will be mapped to as `NSPredicate`.
    public static func safe<Entity: Fetchable>(_ predicate: Builders.Predicate<Entity>) -> NSPredicate {
        predicate.nsValue
    }

    /// Returns a `NSPredicate` built from a SafeFetching predicate.
    /// - Parameters:
    ///   - _: Entity type used to build the predicate.
    ///   - predicate: A closure that takes an `Entity.FetchableMembers` value to return a SafeFetching predicate.
    @_disfavoredOverload
    public static func safe<SourceEntity: Fetchable>(
        on _: SourceEntity.Type,
        _ predicate: (SourceEntity.FetchableMembers) -> Builders.Predicate<SourceEntity>
    ) -> NSPredicate {
        let predicate = predicate(SourceEntity.fetchableMembers)
        return predicate.nsValue
    }

    /// Returns a `NSPredicate` built from a SafeFetching predicate.
    /// - Parameters:
    ///   - _: Entity type used to build the predicate.
    ///   - predicate: A closure that takes an `Entity.FetchableMembers` value to return a SafeFetching predicate.
    public static func safe<SourceEntity: Fetchable, TargetEntity: Fetchable>(
        on _: SourceEntity.Type,
        _ predicate: (SourceEntity.FetchableMembers) -> Builders.Predicate<TargetEntity>
    ) -> NSPredicate {
        let predicate = predicate(SourceEntity.fetchableMembers)
        return predicate.nsValue
    }

    /// Returns a `NSPredicate` built from a SafeFetching predicate.
    /// - Parameters:
    ///   - _: Entity type used to build the predicate.
    ///   - fetchableMember: A closure that takes an `Entity.FetchableMembers` value to return a `FetchableMember` targeting a Boolean attribute of `Entity`.
    public static func safe<SourceEntity: Fetchable, TargetEntity: Fetchable>(
        on _: SourceEntity.Type,
        _ fetchableMember: (SourceEntity.FetchableMembers) -> FetchableMember<TargetEntity, Bool>
    ) -> NSPredicate {
        let fetchableMember = fetchableMember(SourceEntity.fetchableMembers)
        let predicate = Builders.Predicate<TargetEntity>(identifier: fetchableMember.identifier, operatorString: "==", value: true)
        return predicate.nsValue
    }
}
