//
// SafeFetching
// Copyright © 2021-present Alexis Bridoux.
// MIT license, see LICENSE file for details

import CoreData

// MARK: - Setting

extension Builders.Request {

    /// Sets a property of the request.
    public func setting<Value>(_ keyPath: ReferenceWritableKeyPath<FetchRequest, Value>, to value: Value) -> Self {
        request[keyPath: keyPath] = value
        return self
    }
}

// MARK: - Fetch

public extension Builders.PreRequest where Step == CreationStep {

    /// Stops after a first element is fetched.
    func first() -> Builders.Request<Entity, TargetStep, Fetched?> {
        request.fetchLimit = 1
        return Builders.Request<Entity, TargetStep, Fetched?>(request: request)
    }

    /// Stops after the first nth elements are fetched.
    /// - Parameters:
    ///   - limit: How much elements should be fetched.
    ///   - offset: Ignore the first elements found in the offset range.
    func first(nth limit: Int, after offset: Int? = nil) -> Builders.Request<Entity, TargetStep, [Fetched]> {
        request.fetchLimit = limit
        assign(offset, ifNotNilTo: \.fetchOffset)
        return Builders.Request<Entity, TargetStep, [Fetched]>(request: request)
    }

    /// Stops after the all the elements are fetched.
    /// - Parameters:
    ///   - offset: Ignore the first elements found in the offset range.
    func all(after offset: Int? = nil) -> Builders.Request<Entity, TargetStep, [Fetched]> {
        assign(offset, ifNotNilTo: \.fetchOffset)
        return Builders.Request<Entity, TargetStep, [Fetched]>(request: request)
    }


    private func assign<Value>(_ value: Value?, ifNotNilTo keyPath: ReferenceWritableKeyPath<NSFetchRequest<Entity>, Value>) {
        if let value = value {
            request[keyPath: keyPath] = value
        }
    }
}

// MARK: - Predicate

public extension Builders.Request where Step == TargetStep {

    /// Adds a predicate to the request.
    func `where`(_ predicate: Builders.Predicate<Entity>) -> Builders.Request<Entity, PredicateStep, Output> {
        request.predicate = predicate.nsValue
        return .init(request: request)
    }

    /// Adds a predicate to the request.
    ///
    /// ### Examples
    ///  - `.where { $0.name == "Endo" }`
    ///  - `.where { $0.age >= 20 && $0.score * .isIn(10...20) }`
    func `where`(_ predicate: (Entity.FetchableMembers) -> Builders.Predicate<Entity>) -> Builders.Request<Entity, PredicateStep, Output> {
        request.predicate = predicate(Entity.fetchableMembers).nsValue
        return .init(request: request)
    }

    /// Adds a single boolean predicate to the request.
    ///
    /// ### Examples
    ///  - `.where { $0.isDownloaded }`.
    ///  - `.where { !$0.isDownloaded }`.
    func `where`(_ predicate: (Entity.FetchableMembers) -> FetchableMember<Entity, Bool>) -> Builders.Request<Entity, PredicateStep, Output> {
        request.predicate = Builders.Predicate<Entity>(identifier: predicate(Entity.fetchableMembers).identifier).nsValue
        return .init(request: request)
    }

    /// Adds a single boolean predicate to the request.
    ///
    /// ### Examples
    ///  - `.where(\.isDownloaded)`.
    func `where`(_ keyPath: KeyPath<Entity.FetchableMembers, FetchableMember<Entity, Bool>>) -> Builders.Request<Entity, PredicateStep, Output> {
        request.predicate = Builders.Predicate<Entity>(identifier: Entity.fetchableMembers[keyPath: keyPath].identifier).nsValue
        return .init(request: request)
    }
}


// MARK: - Sort

public extension Builders.Request where Step: SortableStep {

    /// Adds a sort descriptor and additional ones to the request.
    ///
    /// ### Examples
    /// - `.sorted(by: .ascending(\.name))`
    /// - `.sorted(by: .ascending(\.name), .descending(\.age))`
    /// - `.sorted(by: .ascending(\.name, using: String.localizedStandardCompare))`
    func sorted(
        by sort: SortDescriptor<Entity>,
        _ additionalSorts: SortDescriptor<Entity>...
    ) -> Builders.Request<Entity, PredicateStep, Output> {
        request.sortDescriptors = ([sort] + additionalSorts).map(\.descriptor)
        return .init(request: request)
    }
}

