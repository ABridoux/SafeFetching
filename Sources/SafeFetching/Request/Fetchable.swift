//
// SafeFetching
// Copyright © 2021-present Alexis Bridoux.
// MIT license, see LICENSE file for details

import CoreData

// MARK: - Fetchable

public protocol Fetchable: NSManagedObject {

    associatedtype FetchableMembers

    static var fetchableMembers: FetchableMembers { get }
}

// MARK: - Static

extension Fetchable {

    /// `NSFetchRequest` to fetch the entity
    public static func newFetchRequest() -> NSFetchRequest<Self> { .init(entityName: String(describing: Self.self)) }

    public static func request() -> Builders.PreRequest<Self, CreationStep, Self> {
        Builders.PreRequest(request: newFetchRequest())
    }
}
