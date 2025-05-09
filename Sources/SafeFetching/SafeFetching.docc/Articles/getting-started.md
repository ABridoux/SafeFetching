# Using SafeFetching: Getting Started

Quick overview to start using SafeFetching and write fetch requests the easy way.

## Overview
This article uses the following managed object.

```swift
@objc(User)
final class User: NSManagedObject {
    @NSManaged var name: String
    @NSManaged var score: Int32
}
```

### Conform to Fetchable
The first step to use SafeFetching with `User` is to make it conform to ``Fetchable``.

```swift
extension User: Fetchable {

    static var fetchableMembers: FetchableMembers { fetchableMembers }

    struct FetchableMembers {
        let name = FetchableMember<User, String>(identifier: "name")
        let score = FetchableMember<User, Int32>(identifier: "score")
    }
}
```

It's also possible to use the `FetchableManagedObject` macro directly.

```swift
@FetchableManagedObject
@objc(User)
final class User: NSManagedObject {
    @NSManaged var name: String
    @NSManaged var score: Int32
}
```
> Tip: When using the macro, it's possible to extend `User.FetchableMembers` to add attributes or relationships that the macro cannot find in the declarations, such as when the property is defined in a parent class.

To ignore an attribute or a relationship when using the `FetchableManagedObject` macro, annotate it with `@FetchingIgnored`. This will effectively not generate a `FetchableMember` for the annotated property.

### Fetch User
Once `User` conforms to `Fetchable`, it gains the static function ``Fetchable/request()`` to start building a fetch request. It's then possible to specify that all `User` entries should be fetched or just one, filter them using predicates and so on.

For instance, here is a statement to fetch all users.

```swift
try User.request().all().fetch(in: context) // [User]
```
Where `context` is a `NSManagedObjectContext`.

To filter the `User` with a predicate, add a `where(_:)` call after `all()`.

```swift
try User.request()
    .all()
    .where { $0.name.hasPrefix("Anna") }
    .fetch(in: context) // [User]
```

The `where(_:)` expects a predicate built on the provided `User.FetchableMembers` that is then converted to a `NSPredicate` with the appropriate format. The predicate is built using operators overloads or extensions on `FetchableMember`. Writing more complex predicates still feels natural.

```swift
try User.request()
    .all()
    .where { $0.name.hasPrefix("Anna") && $0.score < 10 }
    .fetch(in: context) // [User]
```

Finally, by importing `SafeFetching` with `@_spi(SafeFetching)`, more convenience functions are available such as extensions on collections to make the predicates even closer to Swift syntax, while still generating the proper format for `NSPredicate`.


```swift
@_spi(SafeFetching) import SafeFetching

let scores: [Int32] = [10, 20, 30]
try User.request()
    .all()
    .where { scores.contains($0.score) }
    .fetch(in: context) // [User]
```

### What's Next
- Learn more about predicates by reading <doc:build-predicates>.
- Learn more about request building by reading <doc:build-requests>.
