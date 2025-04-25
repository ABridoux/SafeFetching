//
// SafeFetching
// Copyright © 2021-present Alexis Bridoux.
// MIT license, see LICENSE file for details

import CoreData

/// Wrapper around `NSSortDescriptor`
public struct SortDescriptor<Entity: NSManagedObject> {
    public let descriptor: NSSortDescriptor
}

public extension SortDescriptor {

    // MARK: Ascending

    static func ascending<Value: Comparable>(_ keyPath: KeyPath<Entity, Value>) -> SortDescriptor {
        SortDescriptor(descriptor: .init(key: String(keyPath.label), ascending: true))
    }

    static func ascending<Value: Comparable>(_ keyPath: KeyPath<Entity, Value?>) -> SortDescriptor {
        SortDescriptor(descriptor: .init(key: String(keyPath.label), ascending: true))
    }

    static func ascending<Value>(_ keyPath: KeyPath<Entity, Value>, using comparator: @escaping Comparator) -> SortDescriptor {
        SortDescriptor(descriptor: .init(key: String(keyPath.label), ascending: true, comparator: comparator))
    }

    static func ascending<Value>(_ keyPath: KeyPath<Entity, Value>, using selector: Selector) -> SortDescriptor {
        SortDescriptor(descriptor: .init(key: String(keyPath.label), ascending: true, selector: selector))
    }

    // MARK: Descending

    static func descending<Value: Comparable>(_ keyPath: KeyPath<Entity, Value>) -> SortDescriptor {
        SortDescriptor(descriptor: .init(key: String(keyPath.label), ascending: false))
    }

    static func descending<Value: Comparable>(_ keyPath: KeyPath<Entity, Value?>) -> SortDescriptor {
        SortDescriptor(descriptor: .init(key: String(keyPath.label), ascending: false))
    }

    static func descending<Value>(_ keyPath: KeyPath<Entity, Value>, using comparator: @escaping Comparator) -> SortDescriptor {
        SortDescriptor(descriptor: .init(key: String(keyPath.label), ascending: false, comparator: comparator))
    }

    static func descending<Value>(_ keyPath: KeyPath<Entity, Value>, using selector: Selector) -> SortDescriptor {
        SortDescriptor(descriptor: .init(key: String(keyPath.label), ascending: false, selector: selector))
    }
}

