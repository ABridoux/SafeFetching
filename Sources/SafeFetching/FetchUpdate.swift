//
// SafeFetching
// Copyright © 2021-present Alexis Bridoux.
// MIT license, see LICENSE file for details

import CoreData
import Combine

// MARK: - FetchUpdate

extension Publishers {

    /// Tranforms a fetch controller delegate functions to a publisher
    public struct FetchUpdate<Entity: NSManagedObject>: Publisher {

        public typealias Output = [Entity]
        public typealias Failure = Never

        private let subject = PassthroughSubject<[Entity], Never>()
        private let fetchController: NSFetchedResultsController<Entity>
        private var fetchControllerDelegate: FetchControllerDelegate?

        public init(controller: NSFetchedResultsController<Entity>) {
            fetchController = controller
            fetchControllerDelegate = FetchControllerDelegate(sendUpdate: sendUpdate)
            fetchController.delegate = fetchControllerDelegate
            // send a first value
            try? fetchController.performFetch()
            sendUpdate()
        }

        public func receive<S>(subscriber: S) where S: Subscriber, Self.Failure == S.Failure, Self.Output == S.Input {
            subject.receive(subscriber: subscriber)
        }

        private func sendUpdate() {
            guard let objects = fetchController.fetchedObjects else { return }
            subject.send(objects)
        }
    }
}

extension Publishers.FetchUpdate {

    private final class FetchControllerDelegate: NSObject, NSFetchedResultsControllerDelegate {

        let sendUpdate: () -> Void

        init(sendUpdate: @escaping () -> Void) {
            self.sendUpdate = sendUpdate
        }

        func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
            sendUpdate()
        }
    }
}

// MARK: - Access

extension Publishers {

    static func fetchUpdate<Entity>(for type: Entity.Type, fetchController: NSFetchedResultsController<Entity>)
    -> FetchUpdate<Entity>
    where Entity: NSManagedObject {
        FetchUpdate<Entity>(controller: fetchController)
    }
}

extension Fetchable {

    /// Publishes an array of the current `Entity` retrieved with the `NSFetchedResultsController` created
    /// from the provided request..
    /// - Parameters:
    ///   - request: A custom request to use
    ///   - context: The context where to perform the request.
    ///
    /// - note: Emits a first value upon subscription
    public static func updatePublisher(
        for request: NSFetchRequest<Self>? = nil,
        in context: NSManagedObjectContext)
    -> AnyPublisher<[Self], Never> {

        let controller = updateResultController(
            for: request ?? newFetchRequest(),
            in: context)

        return updatePublisher(for: controller)
    }

    /// Publishes an array of the current `Entity` retrieved with the provided `NSFetchedResultsController`
    public static func updatePublisher(for controller: NSFetchedResultsController<Self>) -> AnyPublisher<[Self], Never> {
        Publishers.fetchUpdate(for: Self.self, fetchController: controller)
            .eraseToAnyPublisher()
    }

    private static func updateResultController(
        for request: NSFetchRequest<Self>?,
        in context: NSManagedObjectContext)
    -> NSFetchedResultsController<Self> {

        let request = request ?? newFetchRequest()
        return NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
    }
}
