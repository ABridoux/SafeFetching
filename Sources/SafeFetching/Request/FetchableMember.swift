//
// SafeFetching
// Copyright © 2021-present Alexis Bridoux.
// MIT license, see LICENSE file for details

// MARK: - FetchableMember

/// Stores types and identifier of an entity and attribute or relationship that can be used for fetching.
@dynamicMemberLookup
public struct FetchableMember<Entity: Fetchable, Value>: Sendable {

    // MARK: Properties

    /// Attribute or relationship identifier used to generate `NSPredicate`.
    public let identifier: String

    // MARK: Init

    public init(identifier: String) {
        self.identifier = identifier
    }
}

// MARK: - dynamicMemberLookup

extension FetchableMember {

    public subscript<V>(
        dynamicMember dynamicMember: KeyPath<Value.FetchableMembers, FetchableMember<Value, V>>
    ) -> FetchableMember<Value, V> where Value: Fetchable {
        let member = Value.fetchableMembers[keyPath: dynamicMember]
        return FetchableMember<Value, V>(identifier: "\(identifier).\(member.identifier)")
    }

    public subscript<T, V>(
        dynamicMember dynamicMember: KeyPath<T.FetchableMembers, FetchableMember<T, V>>
    ) -> FetchableMember<T, V> where T: Fetchable, Value == T? {
        let member = T.fetchableMembers[keyPath: dynamicMember]
        return FetchableMember<T, V>(identifier: "\(identifier).\(member.identifier)" )
    }
}
