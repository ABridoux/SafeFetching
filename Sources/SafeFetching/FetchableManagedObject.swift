//
// SafeFetching
// Copyright © 2021-present Alexis Bridoux.
// MIT license, see LICENSE file for details

// MARK: - FetchableManagedObject

/// Add `FetchableMembers` and `fetchableMembers` to a `NSManagedObject` to make it conform to `Fetchable`.
@attached(memberAttribute)
@attached(member, names: arbitrary)
@attached(extension, conformances: Fetchable)
public macro FetchableManagedObject() = #externalMacro(
    module: "SafeFetchingMacros",
    type: "FetchableManagedObjectMacro"
)
