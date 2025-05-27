//
// SafeFetching
// Copyright © 2021-present Alexis Bridoux.
// MIT license, see LICENSE file for details

// MARK: - FetchResult

/// Type that can be used as the result of a fetch request.
public protocol FetchResult {

    // MARK: Associated Types

    associatedtype Fetched: Fetchable

    // MARK: Init

    init(results: [Fetched])
}

// MARK: - Array + FetchResult

extension Array: FetchResult where Element: Fetchable {

    public init(results: [Element]) {
        self = results
    }
}

// MARK: - Optional + FetchResult

extension Optional: FetchResult where Wrapped: Fetchable {

    public init(results: [Wrapped]) {
        self = results.first
    }
}
