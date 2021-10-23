# ``SafeFetching``

Convenience functions around `CoreData` fetching.

## Overview

This library offers a DSL (Domain Specific Language) to build predicates and requests to fetch a CoreData store. Also a wrapper around `NSFetchedResultsController` is offered to publish arrays of `NSManagedObject` to be used with a `NSDiffableDataSource`.

## Topics

### Build predicates
- <doc:build-predicates>
- ``Builders/Predicate``
- ``Builders/PredicateRightValue``
- ``Builders/CompoundPredicate``
- ``SafeFetching/==(_:_:)``
- ``SafeFetching/!=(_:_:)``
- ``SafeFetching/_(_:_:)-1aleq``
- ``SafeFetching/_(_:_:)-77yf7``
- ``SafeFetching/_=(_:_:)-7rogb``
- ``SafeFetching/_=(_:_:)-7wms3``
- ``SafeFetching/&&(_:_:)``
- ``SafeFetching/__(_:_:)``
- ``SafeFetching/*(_:_:)``

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
- ``Fetchable/updatePublisher(sortingBy:_:for:in:)``
