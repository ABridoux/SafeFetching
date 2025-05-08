# Build Requests

Learn how to build requests with the SafeFetching DSL.

Examples in the article refer to this `User`class.

```swift
@FetchableManagedObject
final class User: NSManagedObject {
    @NSManaged var score = 0.0
    @NSManaged var name: String? = ""
    @NSManaged var isAdmin: Bool
}
```

## Setup

To be able to use the DSL for an entity it is needed to make it conform to `Fetchable` which is done here using the ``FetchableManagedObject()`` macro. Then the request creation starts with `User.request()`.

## Steps
There are four steps (some are optional) to build a request:
- specify a target
- specify a predicate (optional)
- specify sorts (optional)
- get either the build request `NSFetchRequest` with ``Builders/Request/nsValue`` or execute it directly with ``Builders/Request/fetch(in:)``

Additionally, the "setting" step can be performed to set a property of `NSFetchRequest` before using it for fetching the store.

### Target

##### All
To target all entities (which is the default behavior of CoreData's fetch requests), use the ``Builders/PreRequest/all(after:)`` function.

```swift
User.request()
    .all()
```

To ignore the first nth results.

```swift
User.request()
    .all(after: 10)
```

##### First
To target the first User meeting the criteria, use ``Builders/PreRequest/first()`` and ``Builders/PreRequest/first(nth:after:)``

```swift
User.request()
    .first()
```

Ignore the first nth results.

```swift
User.request()
    .first(after: 10)
```

Limit the results.

```swift
User.request()
    .first(20)
```

Limit the results and ignore the nth first.

```swift
User.request()
    .first(20, after: 10)
```

### Predicate

Specify a predicate with one of the `where(_:)` functions after the target.

```swift
User.request()
    .all()
    .where { $0.score > 20 }
```

Compound predicates are also supported.

```swift
User.request()
    .all()
    .where { $0.score > 20 && $0.name.contains("dore") }
```

Single boolean values can be used.

```swift
User.request()
    .all()
    .where { $0.isAdmin }
```

> Tip: The `where(_:)` function has convenient variations to take a single boolean like ``Builders/Request/where(_:)-3pukm``: 
> 
> `.where(\.isAdmin)`.

Naming the parameter can sometimes be preferable for longer predicates.

```swift
User.request()
    .all()
    .where { members in 
        members.score > 20 && members.name.contains("dore")
        || !members.isAdmin
    }
```

To learn more about building predicates, you can read <doc:build-predicates>.

### Sort
After the target has been specified, one sort or more can be set to the request with ``Builders/Request/sorted(by:_:)``.

```swift
User.request()
    .all()
    .sorted(by: .ascending(\.name))
```

```swift
User.request()
    .all()
    .sorted(by: .ascending(\.name), .descending(\.score))
```

### Additional settings
If needed, it's possible to assign a value to a property of the request being built with ``Builders/Request/setting(_:to:)``.

```swift
User.request()
    .all()
    .setting(\.returnsDistinctResults, to: true)
```

## Steps order
Whereas some steps cannot be performed in a random order, others like the "setting" can be used any time after the target is specified. That said, it's advised to keep the following order:

- target
- predicate
- sorts
- get/execute request

For instance, here is a request with all the possible/required steps.

```swift
User.request()
    .all(after: 10)
    .where { $0.score >= 15 || $0.name != "Winner" }
    .sorted(by: .ascending(\.score), .descending(\.name))
    .setting(\.returnsDistinctResults, to: true)
    .nsValue
```
