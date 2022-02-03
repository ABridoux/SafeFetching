//
// SafeFetching
// Copyright © 2021-present Alexis Bridoux.
// MIT license, see LICENSE file for details

import SafeFetching
import XCTest

final class RequestBuilderTests: XCTestCase {

    func testMakeRequestAll() {
        let request = StubEntity.request().all().nsValue

        XCTAssertEqual(request.fetchLimit, 0)
        XCTAssertEqual(request.fetchOffset, 0)
        XCTAssertNil(request.predicate)
    }

    func testMakeRequestAllAfter() {
        let request = StubEntity.request().all(after: 10).nsValue

        XCTAssertEqual(request.fetchLimit, 0)
        XCTAssertEqual(request.fetchOffset, 10)
        XCTAssertNil(request.predicate)
    }

    func testMakeRequestFirst() {
        let request = StubEntity.request().first().nsValue

        XCTAssertNil(request.predicate)
    }

    func testMakeRequestFirstNth() {
        let request = StubEntity.request().first(nth: 10).nsValue

        XCTAssertEqual(request.fetchLimit, 10)
        XCTAssertNil(request.predicate)
    }

    func testMakeRequestFirstNthAfterNth() {
        let request = StubEntity.request().first(nth: 10, after: 20).nsValue

        XCTAssertEqual(request.fetchOffset, 20)
        XCTAssertEqual(request.fetchLimit, 10)
        XCTAssertNil(request.predicate)
    }

    func testMakeRequestPredicate() {
        let request = StubEntity.request().all().where(\.score == 10).nsValue

        XCTAssertNotNil(request.predicate)
    }

    func testMakeRequestPredicate2() {
        let request = StubEntity.request()
            .all()
            .where(\.score == 10 && \.name == "Toto" || \.score * .isIn(0...20))
            .nsValue

        XCTAssertNotNil(request.predicate)
    }

    func testMakeRequestPredicate_SingleBool() {
        let request = StubEntity.request().all().where(\.isDownloaded).nsValue

        XCTAssertNotNil(request.predicate)
    }

    func testMakeRequestSort() {
        let request = StubEntity.request()
            .all()
            .sorted(by: .ascending(\.name))
            .nsValue

        XCTAssertEqual(request.sortDescriptors?.count, 1)
    }

    func testMakeRequest2Sort() {
        let request = StubEntity.request()
            .all()
            .sorted(by: .ascending(\.name), .descending(\.score))
            .nsValue

        XCTAssertEqual(request.sortDescriptors?.count, 2)
    }

    func testMakeRequestPredicateThenSort() {
        let request = StubEntity.request()
            .all()
            .where(\.name * .hasPrefix("Yo"))
            .sorted(by: .ascending(\.name))
            .nsValue

        XCTAssertNotNil(request.predicate)
        XCTAssertEqual(request.sortDescriptors?.count, 1)
    }

    func testMakeRequestSettingProperty() {
        let request = StubEntity.request()
            .all()
            .setting(\.returnsDistinctResults, to: true)
            .nsValue

        XCTAssertTrue(request.returnsDistinctResults)
    }
}

// MARK: - Models

extension RequestBuilderTests {

    final class StubEntity: NSManagedObject, Fetchable {

        @objc var score = 0.0
        @objc var name: String? = ""
        @objc var isDownloaded = false
    }
}

extension StringKeyPath where Entity == RequestBuilderTests.StubEntity, Value == Int32 {

    static var stubDatabaseValue: Self { Self(key: "stubDatabaseValue") }
}
