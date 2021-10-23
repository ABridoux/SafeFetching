# ``SafeFetching``

Convenience functions around `CoreData` fetching.

## Overview

This library offers a DSL (Domain Specific Language) to build predicates and requests to fetch a CoreData store. Also a wrapper around `NSFetchedResultsController` is offered to publish arrays of `NSManagedObject` to be used with a `NSDiffableDataSource`.

## Topics

### Build predicates
- <doc:build-predicates>
- ``Builders/BooleanPredicate``
- ``Builders/BooleanPredicateRightValue``
- ``Builders/CompoundPredicate``
- ``SafeFetching/==(_:_:)``
- ``SafeFetching/!=(_:_:)``
- ``SafeFetching/_(_:_:)-1gmvw``
- ``SafeFetching/_=(_:_:)-5yani``
- ``SafeFetching/_(_:_:)-9p2zu``
- ``SafeFetching/_=(_:_:)-7hq68``
- ``SafeFetching/&&(_:_:)``
- ``SafeFetching/__(_:_:)``
- ``SafeFetching/*(_:_:)``

### Build requests
- ``Builders/Request``
- ``SortDescriptor``
- ``RequestBuilderStep``
- ``SortableStep``
- ``CreationStep``
- ``PredicateStep``
- ``TargetStep``
- ``Fetchable``
- ``FetchResult``
