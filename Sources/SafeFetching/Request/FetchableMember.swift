//
// SafeFetching
// Copyright © 2021-present Alexis Bridoux.
// MIT license, see LICENSE file for details

// MARK: - FetchableMember

/// Stores types and identifier of an entity and attribute or relationship that can be used for fetching.
@dynamicMemberLookup
public struct FetchableMember<Entity: Fetchable, Value>: Sendable {

    // MARK: Properties

    public let identifier: String

    // MARK: Init

    public init(identifier: String) {
        self.identifier = identifier
    }
}

// MARK: - dynamicMemberLookup

extension FetchableMember {

    public subscript(dynamicMember dynamicMember: KeyPath<Value.FetchableMembers?, FetchableMember<Entity, Value>>) -> FetchableMember<Entity, Value> where Value: Fetchable {
        let member = Value.fetchableMembers[keyPath: dynamicMember]
        return FetchableMember<Entity, Value>(identifier: "\(identifier).\(member.identifier)")
    }

    public subscript<T, V>(dynamicMember dynamicMember: KeyPath<T.FetchableMembers, FetchableMember<Entity, V>>) -> FetchableMember<T, V> where T: Fetchable, Value == T? {
        let member = T.fetchableMembers[keyPath: dynamicMember]
        return FetchableMember<T, V>(identifier: "\(identifier).\(member.identifier)" )
    }
}
