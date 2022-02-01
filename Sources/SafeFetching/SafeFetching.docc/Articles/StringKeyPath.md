# ``SafeFetching/StringKeyPath``

@Metadata {
    @DocumentationExtension(mergeBehavior: append)
}

## Overview

Define a ``StringKeyPath`` for a computed property on a `NSManagedObject` to be able to use in a predicate. 
Useful when the entity is generated automatically with the code to use a RawRepresentable value.

- note: Using `KeyPath`s for this case would not work because key paths have to target an Objc property to be used directly in a `NSPredicate` 

For instance with the entity `StubEntity`:

```swift
// could be generated with a script

final class StubEntity: NSManagedObject {
    var score: Score? {
        get {
            let key = "score"
            guard let value = primitiveValue(forKey: key) as? Score.RawValue else {
              return nil
            }
            return Score(rawValue: value)
        }

        set {
            let key = "score"
            setPrimitiveValue(newValue?.rawValue, forKey: key)
        }
}

extension Builders.StringKeyPath where Entity == StubEntity, Value == Score {
   static var score: Self { Self(key: "score") }
}
```

In another file

```swift
enum Score: String {
    case low, medium, high
}
```

You can then use the key in a predicate with the enum.

```swift
StubEntity
    .request()
    .all()
    .where(.score == .low)
    .nsValue
```

```swift
StubEntity
    .request()
    .all()
    .where(.score * .isIn([.medium, .high]))
    .nsValue
```
