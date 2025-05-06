//
// SafeFetching
// Copyright © 2021-present Alexis Bridoux.
// MIT license, see LICENSE file for details

import CoreData

// MARK: - PreRequest

extension Builders {

    /// `RequestBuilder` with no target
    public struct PreRequest<Entity: Fetchable, Step: RequestBuilderStep, Fetched: Fetchable> {

        // MARK: Properties

        var request: NSFetchRequest<Entity>
    }
}

// MARK: - Request

extension Builders {

    public struct Request<Entity: Fetchable, Step: RequestBuilderStep, Output: FetchResult> {

        // MARK: Type alias

        public typealias FetchRequest = NSFetchRequest<Entity>

        // MARK: Properties

        let request: FetchRequest

        // MARK: Computed

        /// The built `NSFetchRequest<Entity>`
        public var nsValue: FetchRequest { request }
    }
}

// MARK: - Fetch

extension Builders.Request where Output.Fetched == Entity {

    /// Execute the fetch request in the provided context.
    ///
    /// - returns: Depending the target (all, first), the output is either an optional or an array of `Entity`
    public func fetch(in context: NSManagedObjectContext) throws -> Output {
        Output(results: try context.fetch(request))
    }
}
