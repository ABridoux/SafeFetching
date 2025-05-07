//
// SafeFetching
// Copyright © 2021-present Alexis Bridoux.
// MIT license, see LICENSE file for details

import SafeFetching
import Testing
import CoreData

// MARK: - RequestBuilder

@Suite("Request Builder")
struct RequestBuilder {}

// MARK: - Amount

extension RequestBuilder {

    @Test("Request to Fetch All")
    func makeRequest_all() {
        let request = StubEntity.request().all().nsValue

        #expect(request.fetchLimit == 0)
        #expect(request.fetchOffset == 0)
        #expect(request.predicate == nil)
    }

    @Test("Request to Fetch All After")
    func makeRequest_allAfter() {
        let request = StubEntity.request().all(after: 10).nsValue

        #expect(request.fetchLimit == 0)
        #expect(request.fetchOffset == 10)
        #expect(request.predicate == nil)
    }

    @Test("Request to Fetch All After")
    func makeRequest_first() {
        let request = StubEntity.request().first().nsValue

        #expect(request.predicate == nil)
    }

    @Test("Request to Fetch First Nth")
    func testMakeRequestFirstNth() {
        let request = StubEntity.request().first(nth: 10).nsValue

        #expect(request.fetchLimit == 10)
        #expect(request.predicate == nil)
    }

    @Test("Request to Fetch First Nth after Mth")
    func makeRequest_firstNthAfterNth() {
        let request = StubEntity.request().first(nth: 10, after: 20).nsValue

        #expect(request.fetchOffset == 20)
        #expect(request.fetchLimit == 10)
        #expect(request.predicate == nil)
    }
}

// MARK: - Predicate

extension RequestBuilder {

    @Test("Check Predicate Simple")
    func makeRequest_predicateSimple() {
        let request = StubEntity.request().all().where { $0.score == 10 }.nsValue

        #expect(request.predicate != nil)
    }

    @Test("Check Predicate Compound")
    func makeRequest_predicateCompound() {
        let request = StubEntity.request()
            .all()
            .where { $0.score == 10 && $0.name == "Toto" || $0.score.isIn(0...20) }
            .nsValue

        #expect(request.predicate != nil )
    }

    @Test("Check Predicate Single Bool")
    func makeRequestPredicate_singleBool() {
        let request = StubEntity.request().all().where(\.isDownloaded).nsValue

        #expect(request.predicate != nil )
    }
}

// MARK: - Sort

extension RequestBuilder {

    @Test("Check Single Sort")
    func makeRequest_singleSort() {
        let request = StubEntity.request()
            .all()
            .sorted(by: .ascending(\.name))
            .nsValue

        #expect(request.sortDescriptors?.count == 1)
    }

    @Test("Check Double Sort")
    func makeRequest_doubleSort() {
        let request = StubEntity.request()
            .all()
            .sorted(by: .ascending(\.name), .descending(\.score))
            .nsValue

        #expect(request.sortDescriptors?.count == 2)
    }
}

// MARK: - Mix

extension RequestBuilder {

    @Test("Request with Predicate and Sort")
    func makeRequest_predicateAndSort() {
        let request = StubEntity.request()
            .all()
            .where { $0.name.hasPrefix("Yo") }
            .sorted(by: .ascending(\.name))
            .nsValue

        #expect(request.predicate != nil)
        #expect(request.sortDescriptors?.count == 1)
    }

    @Test("Request with Property Setting")
    func makeRequestSettingProperty() {
        let request = StubEntity.request()
            .all()
            .setting(\.returnsDistinctResults, to: true)
            .nsValue

        #expect(request.returnsDistinctResults)
    }
}

// MARK: - Models

extension RequestBuilder {

    final class StubEntity: NSManagedObject, Fetchable {

        @objc var score = 0.0
        @objc var name: String? = ""
        @objc var isDownloaded = false

        static let fetchableMembers = FetchableMembers()

        struct FetchableMembers {
            let score = FetchableMember<StubEntity, Double>(identifier: "score")
            let name = FetchableMember<StubEntity, String?>(identifier: "name")
            let isDownloaded = FetchableMember<StubEntity, Bool>(identifier: "isDownloaded")
        }
    }
}
