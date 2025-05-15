# Build Predicates

Learn how to safely specify predicates when building a request.

Examples in the article refer to this entity.

```swift
@FetchableManagedObject
final class User: NSManagedObject {
    @NSManaged var score = 0.0
    @NSManaged var name: String? = ""
}
```

When building a request, the ``Builders/Request/where(_:)-5uzqj`` operation allows to specify a predicate. For a demonstration purpose in this article, predicates are specified after their implicit declaration, as shown below.

```swift
let predicate: Builders.Predicate<User> = .predicate { $0.name == "Toto" }
```

## Comparison

Comparison operators can be used with key paths to specify a property in the entity that should be compared to a test value.

 ###### Equality

```swift
$0.name == "Toto"
```

###### Greater

```swift
$0.score > 20
```

###### Greater than

```swift
$0.score >= 20
```

###### Less

```swift
$0.score < 20
```

###### Less than

```swift
$0.score <= 20
```

##### Boolean

```swift
$0.isAdmin
```

```swift
$0.isAdmin == true
```

Inversion is supported.

```swift
!$0.isAdmin
```


## Advanced Operations
It's possible to use the advanced operators offered by `NSPredicate` safely by calling the dedicated function from ``FetchableMember``.

###### Has Prefix (String property)

```swift
$0.name.hasPrefix("Do")
```

``Builders/StringComparisonOptions`` can be provided to the call.

```swift
$0.name.hasPrefix("Do", options: .caseInsensitive)
```

###### Contains (String property)

```swift
$0.name.contains("Do")
```

Other examples on a numeric property

###### Is In (Numeric property)

```swift
$0.score.isIn(10...20)
```

> Tip: By importing `SafeFetching` with `@_spi(SafeFetching)`, more convenience functions are available such as extensions on collections to make the predicates even closer to Swift syntax, while still generating the proper format for `NSPredicate`.

```swift
(10...20).contains($0.score)
```

###### Matches a Regular Expression (String property)

```swift
$0.name.matches("[A-Za-z]{3}")
```

## Compound
It's possible to use the and `&&` and or `||` operators.

##### And

```swift
$0.name == "Bruce"
    && $0.score.isIn(20..<40)
```

##### Or

```swift
$0.name == "Bruce"
    || $0.score.isIn(20..<40)
```

##### Single booleans

Compound predicates work with single booleans.

```swift
$0.isAdmin && $0.score.isIn(20..<40)
```

```swift
!$0.isAdmin || $0.score.isIn(20..<40)
```

### And - And

Composing predicates with compound predicates is done naturally

```swift
$0.score.isIn(20..<40)
    && $0.name.hasPrefix("Do")
    && $0.name.hasSuffix("remi")
```

### And/Or precedence
Since `&&` precedes `||` in boolean expressions, it's possible to enclose a predicate with brackets to prevent this behavior.

```swift
$0.score.isIn(20..<40)
    && ($0.name.hasPrefix("Do") || $0.name.hasSuffix("remi"))
```

## RawRepresentable
`RawRepresentable` types can be used in the predicate when they conform to ``DatabaseValue`` and ``DatabaseTestValue`` (and thus can be stored as their raw value in the CoreData store).

For instance with the `Colors` enum:

```swift
struct Colors: String, DatabaseValue, DatabaseTestValue {
    case red
    case blue
    case green
}
```

Here are some possible predicates.

```swift
{ members in members.color == .red }
{ members in members.color == color.isIn(.red, .blue) }
```

### Comparison predicates

The same comparison predicates are available:

```swift
$0.color == .red
```

```swift
$0.color != .red
```

### Advanced predicates
The `isIn` operator is also available to check that a collection contains an attribute.

```swift
$0.color.isIn(.red, .blue)
```

```swift
$0.color.isNotIn([.red, .blue])
```

It's also possible to use the `contains` function on the collection.

```swift
[.red, .blue].contains($0.color)
```

> Note: To use functions declared in Swift protocols, such as `Collection.contains(_:)`, or `OptionSet.intersects(_:)`, import SafeFetching with `@_spi(SafeFetching)`. This is to avoid cluttering
other modules.

### OptionSet

With an `OptionSet`, it's advised to rather use the `intersects` predicates.
For instance with the `Colors` option set:

```swift
struct Colors: OptionSet, DatabaseValue, DatabaseTestValue {
    let rawValue: Int

    static let red = StubOptionSet(rawValue: 1 << 0)
    static let blue = StubOptionSet(rawValue: 1 << 1)
    static let green = StubOptionSet(rawValue: 1 << 2)
}
```

The predicate is specified as follow:

```swift
$0.color.intersects([.red, .blue])
```

```swift
[.red, .blue].intersects($0.color)
```

> Note: `$0.color.intersects(.blue)` is only the same as `$0.color == .blue` when the stored `color` is a single option. 

## Relationships
Predicates in SafeFetching support relationships. Given the two entities:

```swift
@FetchableManagedObject
final class User: NSManagedObject {
    @NSManaged var score = 0.0
    @NSManaged var pet: Pet?
}

@FetchableManagedObject
final class Pet: NSManagedObject {
    @NSManaged var name: String 
}
```
The following predicate can be expressed for the `User` entity.

```swift
$0.pet.name == "Minouche"
```
> Note: Even if `pet` is an optional `Pet` relationship, SafeFetching has no concerns about it when specifying comparison. Optionals are not relevant when writing a `NSPredicate` string format to fetch a CoreData store (unless of course when checking nullity).

### NSManagedObject 
Testing a relationship against another entity is supported (it then uses the `objectID`).

```swift
// otherPet: Pet
$0.pet == otherPet
```


## NSManagedObject Comparisons
Comparison of self is supported (it then uses the `objectID`).

```swift
// someUser: User
$0 == someUser
```

## Standalone predicate
Using a `where(_:)` function is not the only way to make predicate.

### NSPredicate convenience
If needed, a predicate can be specified to make a `NSPredicate`.

```swift
let predicate: NSPredicate = .safe(on: User.self) { $0.score > 10 }
```

### Static
Also, a predicate can be provided with ``Builders/Predicate/predicate(_:)-2fnp0``.

```swift
let predicate: Builders.Predicate<User> = .predicate { $0.score > 10 }
```
