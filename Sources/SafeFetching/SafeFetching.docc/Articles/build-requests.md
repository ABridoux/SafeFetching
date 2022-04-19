# Build requests

Learn how to build requests with the SafeFetching DSL.

Examples in the article refer to this entity.

```swift
final class StubEntity: NSManagedObject {

    @NSManaged var score = 0.0
    @NSManaged  var name: String? = ""
}
```

## Setup

To be able to use the DSL for an entity, the only required step is to make it conform to `Fetchable`.

```swift
extension StubEntity: Fetchable {}
```

Then the request creation starts with `StubEntity.request()`.

## Steps
There are four steps (some are optional) to build a request:
- specify a target
- specify a predicate (optional)
- specify sorts (optional)
- get either the build request `NSFetchRequest` with ``Builders/Request/nsValue`` or execute it directly with ``Builders/Request/fetch(in:)``

Additionally, the "setting" can be performed.

### Target

##### All
To target all entities (which is the default behavior of CoreData's fetch requests), use the ``Builders/PreRequest/all(after:)`` function.

```swift
StubEntity.request()
    .all()
```

To ignore the first nth results:

```swift
StubEntity.request()
    .all(after: 10)
```

##### First
To target the first entity meeting the criteria, use ``Builders/PreRequest/first()`` and ``Builders/PreRequest/first(nth:after:)``

```swift
StubEntity.request()
    .first()
```

Ignore the first nth results

```swift
StubEntity.request()
    .first(after: 10)
```

Limit the results

```swift
StubEntity.request()
    .first(20)
```

Limit the results and ignore the nth first

```swift
StubEntity.request()
    .first(20, after: 10)
```

### Predicate

Specify a predicate with the ``Builders/Request/where(_:)-5ar9o`` function after the target.

```swift
StubEntity.request()
    .all()
    .where(\.score > 20)
```

```swift
StubEntity.request()
    .all()
    .where(\.score > 20
        && \.name * .contains("dore")
    )
```

To learn more about building predicates, you can read <doc:build-predicates>.

### Sort
After the target has been specified, one sort or more can be set to the request with ``Builders/Request/sorted(by:_:)``

```swift
StubEntity.request()
    .all()
    .sorted(by: .ascending(\.name))
```

```swift
StubEntity.request()
    .all()
    .sorted(by: .ascending(\.name), .descending(\.score))
```

### Additional settings
If needed, it's possible to assign a value to the request being built with ``Builders/Request/setting(_:to:)`` which allows to keep the functional appearance.

```swift
StubEntity.request()
    .all()
    .setting(\.returnsDistinctResults, to: true)
```

## Steps order
Whereas some steps cannot be performed in a random order, others like the "setting" can be used any time after the target is specified. That said, it's advised to keep the order used to expose the steps:

- target
- predicate
- sorts
- get/execute request

For instance, here is a request with all the possible/required steps.

```swift
StubEntity.request()
    .all(after: 10)
    .where(\.score >= 15 || \.name != "Winner")
    .sorted(by: .ascending(\.score), .descending(\.name))
    .setting(\.returnsDistinctResults, to: true)
    .nsValue
```
