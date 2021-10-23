//
// SafeFetching
// Copyright © 2021-present Alexis Bridoux.
// MIT license, see LICENSE file for details

/// Type that can be used as the result of a fetch request
public protocol FetchResult {
    associatedtype Fetched: Fetchable

    init(results: [Fetched])
}

extension Array: FetchResult where Element: Fetchable {

    public init(results: [Element]) {
        self = results
    }
}

extension Optional: FetchResult where Wrapped: Fetchable {

    public init(results: [Wrapped]) {
        self = results.first
    }
}
