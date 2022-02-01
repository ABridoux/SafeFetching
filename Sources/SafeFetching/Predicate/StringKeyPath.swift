//
// SafeFetching
// Copyright © 2021-present Alexis Bridoux.
// MIT license, see LICENSE file for details

import CoreData

/// Wrapper around a string key for a property that is not Objc but computed with primitive value
public struct StringKeyPath<Entity: NSManagedObject, Value> {

    public let key: String

    public init(key: String) {
        self.key = key
    }
}
