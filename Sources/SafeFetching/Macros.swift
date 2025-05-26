//
// SafeFetching
// Copyright © 2021-present Alexis Bridoux.
// MIT license, see LICENSE file for details

// MARK: - FetchableManagedObject

/// Add `FetchableMembers` and `fetchableMembers` to a `NSManagedObject` to make it conform to `Fetchable` and add `FetchableMembers`.
@attached(member, names: arbitrary)
@attached(extension, conformances: Fetchable)
public macro FetchableManagedObject() = #externalMacro(module: "SafeFetchingMacros", type: "FetchableManagedObjectMacro")

// MARK: - FetchingIgnored

/// Attached to a property to make it unavailable when fetching attribute or relationships for the `FetchableManagedObject`.
@attached(accessor, names: named(willSet))
public macro FetchingIgnored() = #externalMacro(module: "SafeFetchingMacros", type: "FetchingIgnoredMacro")
