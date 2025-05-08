# ``SafeFetching``

Convenience functions around `CoreData` fetching.

## Overview

This library offers a DSL (Domain Specific Language) to build predicates and requests to fetch a CoreData store. There are three objectives it tries to reach:
1. Use compiler-checking to evaluate predicates and avoid runtime errors.
2. Writing a request and especially a predicate should feel as natural as possible in Swift.
3. No feature of `NSPredicate` to fetch a CoreData store should be left behind.

## Topics

### Essentials
Quickly learn how to use SafeFetching.
- <doc:getting-started>

### Conform to `Fetchable`
`Fetchable` is a protocol that `NSManagedObject` should implement in order to be used with SafeFetching API. It requires to define a `FetchableMembers` type that holds the members (attributes or relationships) that can be fetched, as well as a static `fetchableMember` property to access those. A macro is provided to generate them automatically.

- ``Fetchable``
- ``FetchableManagedObject()``
- ``FetchingIgnored()``

### Build Requests
Start building a request and customize it to fetch one or several entities, filter them, sort them and so on.

- <doc:build-requests>
- ``Builders/Request``
- ``SortDescriptor``
- ``RequestBuilderStep``
- ``SortableStep``
- ``CreationStep``
- ``PredicateStep``
- ``TargetStep``
- ``FetchResult``


### Build Predicates
Predicate are used within a `where()` function when building a request. Meanwhile, a convenience function `NSPredicate.safe(_:)` is provided to create a `NSPredicate` from a SafeFetching predicate.

- <doc:build-predicates>
- ``FetchableMember``
- ``Builders/Predicate``
- ``DatabaseValue``
- ``DatabaseValueIdentification``
- ``DatabaseTestValue``
- ``Builders/CompoundPredicate``

### Namespace
- ``Builders``
