# ``SafeFetching/FetchableManagedObject()``

Add `FetchableMembers` and `fetchableMembers` to a `NSManagedObject` to make it conform to `Fetchable`.

## Usage

This macro adds conformance to ``Fetchable`` and expand the managed object class it is attached to by providing fetchable members.

Given the following `User` class,

```swift
@FetchableManagedObject
final class User: NSManagedObject {
    @NSManaged var score = 0.0
    @NSManaged var name: String? = ""
}
```

the macro expansion will be the following.

```swift
final class User: NSManagedObject {
    @NSManaged var score = 0.0
    @NSManaged var name: String? = ""

    static var fetchableMembers: FetchableMembers { FetchableMembers() }

    struct FetchableMembers: Sendable {
        let score = FetchableMember<User, Double>(identifier: "score")
        let name = FetchableMember<User, String?>(identifier: "name")
    }
}
```

### Additional Members

If needed, `User.FetchableMembers` can still be extended to specify additional members that the macro would not catch, such as when the member is defined in a parent class.

```swift
extension User.FetchableMembers {
    let additionalMember = FetchableMember<User, Bool>(identifier: "additionalMember")
}
```

### Ignore Members
Using ``FetchingIgnored()``, some members (either attributes or relationships) can be excluded from the `FetchableMembers` generation.

```swift
@FetchableManagedObject
final class User: NSManagedObject {
    @NSManaged var score = 0.0

    @FetchingIgnored
    @NSManaged var name: String? = ""
}
```

will be expanded as followed.

```swift
final class User: NSManagedObject {
    @NSManaged var score = 0.0
    @NSManaged var name: String? = ""

    static var fetchableMembers: FetchableMembers { FetchableMembers() }

    struct FetchableMembers: Sendable {
        let score = FetchableMember<User, Double>(identifier: "score")
    }
}
```
