# ``SafeFetching``

Convenience functions around `CoreData` fetching.

## Overview

This library offers a DSL (Domain Specific Language) to build predicates and requests to fetch a CoreData store. Also a wrapper around `NSFetchedResultsController` is offered to publish arrays of `NSManagedObject` to be used with a `NSDiffableDataSource`.

## Topics

### Build predicates

- <doc:build-predicates>
- ``Builders/Predicate``
- ``DatabaseValue``
- ``DatabaseValueIdentification``
- ``DatabaseTestValue``

### Key path predicates

Key paths predicate work with key paths that target a property exposed to Objective-C. For instance `@objc`  or `NSManaged`. To use properties that are automatically converted to be stored, use a ``StringKeyPath``.

- ``Builders/KeyPathPredicateRightValue``
- ``==(_:_:)-23gbz``
- ``!=(_:_:)-sw2d``
- ``_(_:_:)-6ignz``
- ``_=(_:_:)-3bumn``
- ``_(_:_:)-2o0zw``
- ``_=(_:_:)-7tt3x``
- ``!(_:)-k9g0``

### Key path advanced predicates

Advanced predicates like string comparison ``Builders/KeyPathPredicateRightValue/hasPrefix(_:options:)-8tv6z`` or membership ``Builders/KeyPathPredicateRightValue/isIn(_:)-8lnwn`` can be used with the special operator `*`.

- ``*(_:_:)-9ve4y``

### String key path comparison

``StringKeyPath`` allow to define a property name with the entity and value types when the property is not a `NSManaged` one but is transformed to be stored as a database value (like storing the `rawValue` of a `RawRepresentable`).

- ``StringKeyPath``
- ``Builders/StringKeyPathPredicateRightValue``
- ``==(_:_:)-91q9n``
- ``!=(_:_:)-4s1nt``
- ``_(_:_:)-4t33p``
- ``_=(_:_:)-7schv``
- ``_(_:_:)-756zh``
- ``_=(_:_:)-627jw``
- ``!(_:)-84xed``


### String key paths advanced predicates

Advanced predicates like membership ``Builders/StringKeyPathPredicateRightValue/isIn(_:)-2ewm2`` can be used with the special operator `*`.

- ``*(_:_:)-2b678``

### Compound predicate

Use and `&&` and or `||` operators between predicates or with a single boolean key path or string key path..

- ``Builders/CompoundPredicate``
- ``&&(_:_:)-9k2h3``
- ``__(_:_:)-7vb5w``
- ``&&(_:_:)-5awsl``
- ``__(_:_:)-2bklc``
- ``&&(_:_:)-1r2e1``
- ``__(_:_:)-91dq6``
- ``&&(_:_:)-26dgm``
- ``__(_:_:)-k20``
- ``&&(_:_:)-1vytf``
- ``__(_:_:)-6zf3v``

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
