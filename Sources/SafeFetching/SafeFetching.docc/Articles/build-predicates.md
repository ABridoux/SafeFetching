# Build Predicates

Learn how to specify safe predicates safely when building a request.

Examples in the article refer to this entity.

```swift
final class StubEntity: NSManagedObject {

    @NSManaged var score = 0.0
    @NSManaged  var name: String? = ""
}
```

When building a request, the ``Builders/Request/where(_:)-((Entity.FetchableMembers)->Builders.Predicate<Entity>)`` operation allows to specify a predicate. For a demonstration purpose in this article, predicates are specified after their implicit declaration.

```swift
let predicate: Builders.Predicate<StubEntity>
$0.name == "Toto"
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
$0.isAdmin == true
```

```swift
!$0.isAdmin
```

> Tip: The `where(_:)` function has convenient variations to take a single boolean like ``Builders/Request/where(_:)-3pukm``: 
> 
> `.where(\.isAdmin)`.


## Advanced Operations
It's possible to use the advanced operators offered by `NSPredicate` safely by specifying calling the dedicated function from the ``FetchableMember``.

###### Has Prefix (String property)

```swift
$0.name.hasPrefix("Do")
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

###### Matches a Regular Expression (string property)

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
`RawRepresentable` types can be used in the predicate when they conform to ``DatabaseValue`` (and thus can be stored as their raw value in the CoreData store).

For instance with the `Colors` enum:

```swift
struct Colors: String {
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

With an option set, it's advised to rather use the `intersects` predicates.
For instance with the `Colors` option set:

```swift
struct Colors: OptionSet {
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

### Comparing Option Set Values

Do note that
```swift
$0.color.intersects(.blue)
```

is only the same as

```swift
$0.color == .blue
```
*when the stored `color` is a single option*. 
