//
// SafeFetching
// Copyright © 2021-present Alexis Bridoux.
// MIT license, see LICENSE file for details

import CoreData

// MARK: - Fetchable

/// Implemented by a `NSManagedObject` to offer fetching using SafeFetching API.
public protocol Fetchable: NSManagedObject {

    // MARK: Associated Type

    /// Holds the members that can take part in a SafeFetching predicate.
    associatedtype FetchableMembers

    // MARK: Properties

    /// A `FetchableMembers` value used when building predicates.
    static var fetchableMembers: FetchableMembers { get }
}

// MARK: - Static

extension Fetchable {

    /// `NSFetchRequest` to fetch the entity.
    public static func newFetchRequest() -> NSFetchRequest<Self> { .init(entityName: String(describing: Self.self)) }

    /// Starts building a request.
    public static func request() -> Builders.PreRequest<Self, CreationStep, Self> {
        Builders.PreRequest(request: newFetchRequest())
    }
}
