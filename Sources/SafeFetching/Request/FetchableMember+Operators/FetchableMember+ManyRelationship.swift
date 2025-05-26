//
// SafeFetching
// Copyright © 2021-present Alexis Bridoux.
// MIT license, see LICENSE file for details

import CoreData

// MARK: - Contains

extension FetchableMember {

    /// Returns a predicate to check whether the many relationship contains the provided managed object.
    public func contains<E>(_ managedObject: E) -> Builders.Predicate<Entity> where E: NSManagedObject, Value == Set<E> {
        Builders.Predicate(identifier: "ANY \(identifier)", operatorString: "==", managedObject: managedObject)
    }

    /// Returns a predicate to check whether the many relationship contains the provided managed object ID.
    public func contains<E>(_ managedObjectID: NSManagedObjectID) -> Builders.Predicate<Entity> where Value == Set<E> {
        Builders.Predicate(identifier: "ANY \(identifier)", operatorString: "==", managedObjectID: managedObjectID)
    }

    /// Returns a predicate to check whether the many relationship contains the provided managed object.
    ///
    /// - important: This function assumes that the element type of the `NSSet` is a subclass of `NSManagedObject` of type `E`.
    public func contains<E>(_ managedObject: E) -> Builders.Predicate<Entity> where E: NSManagedObject, Value == NSSet {
        Builders.Predicate(identifier: "ANY \(identifier)", operatorString: "==", managedObject: managedObject)
    }

    /// Returns a predicate to check whether the many relationship contains the provided managed object.
    ///
    /// - important: This function assumes that the element type of the `NSSet` is a subclass of `NSManagedObject`.
    public func contains(_ managedObjectID: NSManagedObjectID) -> Builders.Predicate<Entity> where Value == NSSet {
        Builders.Predicate(identifier: "ANY \(identifier)", operatorString: "==", managedObjectID: managedObjectID)
    }
}
