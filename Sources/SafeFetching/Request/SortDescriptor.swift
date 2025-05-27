//
// SafeFetching
// Copyright © 2021-present Alexis Bridoux.
// MIT license, see LICENSE file for details

import CoreData

// MARK: - SortDescriptor

/// Wrapper around `NSSortDescriptor`.
public struct SortDescriptor<Entity: Fetchable> {
    public let descriptor: NSSortDescriptor
}

// MARK: - Ascending

extension SortDescriptor {

    /// Specifies an ascending sort.
    /// - Parameters:
    ///   - keyPath: KeyPath of the attribute that should be used for sorting.
    ///   - comparator: Used to compare values with `NSSortDescriptor`.
    public static func ascending<Value: Comparable>(
        _ keyPath: KeyPath<Entity.FetchableMembers, FetchableMember<Entity, Value>>,
        comparator: Comparator? = nil
    ) -> SortDescriptor {
        let identifier = Entity.fetchableMembers[keyPath: keyPath].identifier
        let descriptor = if let comparator {
            NSSortDescriptor(key: identifier, ascending: true, comparator: comparator)
        } else {
            NSSortDescriptor(key: identifier, ascending: true)
        }
        return SortDescriptor(descriptor: descriptor)
    }

    /// Specifies an ascending sort.
    /// - Parameters:
    ///   - keyPath: KeyPath of the attribute that should be used for sorting.
    ///   - comparator: Used to compare values with `NSSortDescriptor`.
    public static func ascending<Value: Comparable>(
        _ keyPath: KeyPath<Entity.FetchableMembers, FetchableMember<Entity, Value?>>,
        comparator: Comparator? = nil
    ) -> SortDescriptor {
        let identifier = Entity.fetchableMembers[keyPath: keyPath].identifier
        let descriptor = if let comparator {
            NSSortDescriptor(key: identifier, ascending: true, comparator: comparator)
        } else {
            NSSortDescriptor(key: identifier, ascending: true)
        }
        return SortDescriptor(descriptor: descriptor)
    }
}

// MARK: - Descending

extension SortDescriptor {

    /// Specifies a descending sort.
    /// - Parameters:
    ///   - keyPath: KeyPath of the attribute that should be used for sorting.
    ///   - comparator: Used to compare values with `NSSortDescriptor`.
    public static func descending<Value: Comparable>(
        _ keyPath: KeyPath<Entity.FetchableMembers, FetchableMember<Entity, Value>>,
        comparator: Comparator? = nil
    ) -> SortDescriptor {
        let identifier = Entity.fetchableMembers[keyPath: keyPath].identifier
        let descriptor = if let comparator {
            NSSortDescriptor(key: identifier, ascending: false, comparator: comparator)
        } else {
            NSSortDescriptor(key: identifier, ascending: false)
        }
        return SortDescriptor(descriptor: descriptor)
    }

    /// Specifies a descending sort.
    /// - Parameters:
    ///   - keyPath: KeyPath of the attribute that should be used for sorting.
    ///   - comparator: Used to compare values with `NSSortDescriptor`.
    public static func descending<Value: Comparable>(
        _ keyPath: KeyPath<Entity.FetchableMembers, FetchableMember<Entity, Value?>>,
        comparator: Comparator? = nil
    ) -> SortDescriptor {
        let identifier = Entity.fetchableMembers[keyPath: keyPath].identifier
        let descriptor = if let comparator {
            NSSortDescriptor(key: identifier, ascending: false, comparator: comparator)
        } else {
            NSSortDescriptor(key: identifier, ascending: false)
        }
        return SortDescriptor(descriptor: descriptor)
    }
}
