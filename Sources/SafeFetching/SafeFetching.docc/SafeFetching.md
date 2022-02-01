# ``SafeFetching``

Convenience functions around `CoreData` fetching.

## Overview

This library offers a DSL (Domain Specific Language) to build predicates and requests to fetch a CoreData store. Also a wrapper around `NSFetchedResultsController` is offered to publish arrays of `NSManagedObject` to be used with a `NSDiffableDataSource`.

## Topics

### Build predicates

- <doc:build-predicates>
- ``Builders/Predicate``
- ``Builders/CompoundPredicate``
- ``Builders/KeyPathPredicateRightValue``
- ``Builders/StringKeyPathPredicateRightValue``
- ``DatabaseValue``
- ``DatabaseValueIdentification``

### Key path predicates

- <doc:build-predicates>
- ``&&(_:_:)``
- ``__(_:_:)``

### Key path advanced predicates

- <doc:build-predicates>
- ``*(_:_:)-9ve4y``

### String key path comparison

- <doc:build-predicates>
- ``StringKeyPath``
- ``==(_:_:)-3tl1a``
- ``!=(_:_:)-53mz``
- ``_(_:_:)-2t2xr``
- ``_=(_:_:)-8camq``
- ``_(_:_:)-87xrg``
- ``_=(_:_:)-46p18``

### String key paths advanced predicates

- <doc:build-predicates>
- ``*(_:_:)-2b678``

### Build requests

- <doc:build-requests>
- ``Builders/Request``
- ``SortDescriptor``
- ``RequestBuilderStep``
- ``SortableStep``
- ``CreationStep``
- ``PredicateStep``
- ``TargetStep``
- ``Fetchable``
- ``FetchResult``

### Fetch update
- ``Fetchable/updatePublisher(for:)``
- ``Fetchable/updatePublisher(for:in:)``

### Namespace
- ``Builders``
