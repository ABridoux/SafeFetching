# SafeFetching

This library offers a DSL (Domain Specific Language) to safely build predicates and requests to fetch a CoreData store.

The documentation is built with docC. You can [read it online](https://abridoux.github.io/SafeFetching/documentation/safefetching/) or locally by running *Product* → *Build Documentation* or hitting **⇧⌃⌘D**.

## Convenient and Safe Fetching

The library requires to manually define the entity class. Then the macro `FetchableManagedObject` can be used. 

```swift
@FetchableManagedObject
final class User: NSManagedObject {

    @NSManaged var score = 0.0
    @NSManaged var name: String? = ""
}
```
This makes `User` conform to `Fetchable` and ready to be used with the SafeFetching API.

Then it's possible to use the DSL to build a request. The last step can either get the built request as `NSFetchRequest<User>` or execute the request in the provided context.

```swift
User.request()
    .all(after: 10)
    .where { $0.score >= 15 || $0.name != "Joe" }
    .sorted(by: .ascending(\.score), .descending(\.name))
    .setting(\.returnsDistinctResults, to: true)
    .nsValue
```

```swift
User.request()
    .all(after: 10)
    .where { $0.score >= 15 || $0.name != "Joe" }
    .sorted(by: .ascending(\.score), .descending(\.name))
    .setting(\.returnsDistinctResults, to: true)
    .fetch(in: context) // returns [User]
```

Advanced `NSPredicate` operators are also available like `BEGINSWITH` (`hasPrefix`).

```swift
User.request()
    .all()
    .where { $0.name.hasPrefix("Do", options: .caseInsensitive) }
    .nsValue
```

More about that in the [documentation](https://abridoux.github.io/SafeFetching/documentation/safefetching/).

## `NSPredicate`, `Predicate`
Why not using `Predicate` directly? Two reasons:
- It works only with SwiftData as of today (so iOS 17+, macOS 14+ ...). It doesn't work with CoreData.
- It doesn't support everything that `NSPredicate` does when fetching a CoreData store.

Meanwhile, `NSPredicate` requires to write everything in a `String`, which is very error-prone. 

Whereas this library tries to reach three objectives:
1. Use compiler-checking to evaluate predicates and avoid runtime errors.
2. Writing a request and especially a predicate should feel as natural as possible in Swift.
3. No feature of NSPredicate to fetch a CoreData store should be left behind.
