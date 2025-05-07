# ``SafeFetching``

Convenience functions around `CoreData` fetching.

## Overview

This library offers a DSL (Domain Specific Language) to build predicates and requests to fetch a CoreData store.

Learn quickly how to use it by reading <doc:getting-started>.

## Topics

### Build predicates
Predicate are used within a `where()` function when building a request. Meanwhile, a convenience function `NSPredicate.safe(_:)` is provided to create a `NSPredicate` from a SafeFetching predicate.

- <doc:build-predicates>
- ``FetchableMember``
- ``Builders/Predicate``
- ``DatabaseValue``
- ``DatabaseValueIdentification``
- ``DatabaseTestValue``


### Compound predicate

Use and `&&` and or `||` operators between predicates or with a single boolean key path or string key path.

- ``Builders/CompoundPredicate``

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

### Namespace
- ``Builders``
