//
// SafeFetching
// Copyright © 2021-present Alexis Bridoux.
// MIT license, see LICENSE file for details

// MARK: - FetchableMember

public struct FetchableMember<Root, Value> {

    // MARK: Properties

    public let identifier: String

    // MARK: Init

    public init(identifier: String) {
        self.identifier = identifier
    }
}
