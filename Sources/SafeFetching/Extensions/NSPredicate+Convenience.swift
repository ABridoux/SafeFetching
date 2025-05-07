//
// SafeFetching
// Copyright © 2021-present Alexis Bridoux.
// MIT license, see LICENSE file for details

import CoreData

// MARK: - Safe

extension NSPredicate {

    /// Safely builds a predicate for a provided entity type.
    public static func safe<Entity: NSManagedObject>(_ predicate: Builders.Predicate<Entity>) -> NSPredicate {
        predicate.nsValue
    }
}
