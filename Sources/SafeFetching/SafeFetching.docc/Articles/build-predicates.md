# Build predicates

Learn how to specify safe predicates safely when building a request.

Examples in the article refer to this entity.

```swift
final class StubEntity: NSManagedObject {

    @NSManaged var score = 0.0
    @NSManaged  var name: String? = ""
}
```

When building a request, the ``Builders/Request/where(_:)`` operation allows to specify a predicate. For a demonstration purpose in this article, predicates are specified after their implicit declaration.

```swift
let predicate: Builders.Predicate<StubEntity>
predicate = \.name == "Toto"
```

## Comparison

Comparison operators can be used with key paths to specify a property in the entity that should be compared to a test value.

 ###### Equality

```swift
predicate = \.name == "Toto"
```

###### Greater

```swift
predicate = \.score > 20
```

###### Greater than

```swift
predicate = \.score >= 20
```

###### Less

```swift
predicate = \.score < 20
```

###### Less than

```swift
predicate = \.score <= 20
```

## Advanced operations
It's possible to use the advanced operators offered by `NSPredicate` safely by specifying a key path followed by the junction operator `*` then the custom operator.

###### Has prefix (string property)

```swift
predicate = \.name * .hasPrefix("Do")
```

###### Contains (string property)

```swift
predicate = \.name * .contains("Do")
```

Other examples on a numeric property

###### Is in (numeric property)

```swift
predicate = \.score * .isIn(10...20)
```

###### Matches a regular expression (string property)

```swift
predicate = \.name * .matches("[A-Za-z]{3}")
```

The advanced operators can be found with ``Builders/KeyPathPredicateRightValue``

## Compound
It's possible to use the and `&&` and or `||` operators.

##### And

```swift
predicate = \.name == "Bruce"
    && \.score * .isIn(20..<40)
```

##### Or

```swift
predicate = \.name == "Bruce"
    || \.score * .isIn(20..<40)
```

Composing predicates with compound predicates is done naturally

### And - And

```swift
predicate = \.score * .isIn(20..<40)
    && \.name * .hasPrefix("Do")
    && \.name * .hasSuffix("remi")
```

### And/Or precedence
Since `&&` precedes `||` in boolean expressions, it's possible to enclose a predicate with brackets to prevent this behavior.

```swift
predicate = \.score * .isIn(20..<40)
    && (\.name * .hasPrefix("Do") || \.name * .hasSuffix("remi"))
```

## RawRepresentable
When a stored value is the `rawValue` of a `RawRepresentable` type, it's possible to define a ``StringKeyPath`` to be used in a predicate.

For instance with the enum `Color` and a `color: Color?` property and a static `StringKeyPath.color` value.

```swift
enum Color: String {
    case red, blue, green
}
```

### Comparison predicates

The same comparison predicates are available:

```swift
predicate = .color == .red
```

```swift
predicate = .color != .red
```

### Advanced predicates
The `isIn` operator is also available

```swift
predicate = .color * .isIn(.red, .blue)
```

```swift
predicate = .color * .isNotIn([.red, .blue])
```

### OptionSet

With an option set, it's advised to rather use the `intersects` predicates.
With the colors now as an option set:

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
predicate = .color * .intersects([.red, .blue])
```

```swift
predicate = .color * .doesNoIntersect([.red, .blue])
```

### Comparing option set values

Note that
```swift
predicate = .color * .intersects(.blue)
```

is only the same as

```swift
predicate = .color == .blue
```
*when the stored `color` is a single option*. 
