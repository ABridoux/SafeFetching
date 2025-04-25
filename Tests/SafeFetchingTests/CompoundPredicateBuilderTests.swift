//
// SafeFetching
// Copyright © 2021-present Alexis Bridoux.
// MIT license, see LICENSE file for details

import SafeFetching
import CoreData
import XCTest

// MARK: - CompoundPredicateTests

final class CompoundPredicateTests: XCTestCase {

    func testAnd() {
        testNSFormat(
            predicate: \.score == 10 && \.name == "Toto",
            expecting: #"score == 10 AND name == "Toto""#
        )
    }

    func testOr() {
        testNSFormat(
            predicate: \.score == 10 || \.name == "Toto",
            expecting: #"score == 10 OR name == "Toto""#
        )
    }

    func testAndPredicateRightValue() {
        testNSFormat(
            predicate: \.score > 10 && \.name * .hasPrefix("Toto"),
            expecting: #"score > 10 AND name BEGINSWITH "Toto""#
        )
    }

    func testAndCompound() {
        testNSFormat(
            predicate: \.score > 10 && \.name * .hasPrefix("To") && \.name * .hasSuffix("ta"),
            expecting: #"(score > 10 AND name BEGINSWITH "To") AND name ENDSWITH "ta""#
        )
    }

    func testCompoundPrecedence() {
        testNSFormat(
            predicate: \.score > 10 && \.name * .hasPrefix("To") || \.name * .hasSuffix("ta"),
            expecting: #"(score > 10 AND name BEGINSWITH "To") OR name ENDSWITH "ta""#
        )
    }

    func testCompoundBrackets() {
        testNSFormat(
            predicate: \.score > 10 && (\.name * .hasPrefix("To") || \.name * .hasSuffix("ta")),
            expecting: #"score > 10 AND (name BEGINSWITH "To" OR name ENDSWITH "ta")"#
        )
    }

    func testAnd_SingleBoolean_Left() {
        testNSFormat(
            predicate: \.isDownloaded && \.name == "Toto",
            expecting: #"isDownloaded == 1 AND name == "Toto""#
        )
    }

    func testOr_SingleBoolean_Left() {
        testNSFormat(
            predicate: \.isDownloaded || \.name == "Toto",
            expecting: #"isDownloaded == 1 OR name == "Toto""#
        )
    }

    func testAnd_SingleBoolean_Right() {
        testNSFormat(
            predicate: \.name == "Toto" && !\.isDownloaded,
            expecting: #"name == "Toto" AND isDownloaded == 0"#
        )
    }

    func testOr_SingleBoolean_Right() {
        testNSFormat(
            predicate: \.name == "Toto" || \.isDownloaded,
            expecting: #"name == "Toto" OR isDownloaded == 1"#
        )
    }
}

// MARK: - Helpers

extension CompoundPredicateTests {

    func testNSFormat(
        predicate: Builders.CompoundPredicate<StubEntity>,
        expecting format: String
    ) {
        XCTAssertEqual(predicate.nsValue.predicateFormat, format)
    }
}

// MARK: - Models

extension CompoundPredicateTests {

    final class StubEntity: NSManagedObject {

        @objc var score = 0.0
        @objc var name: String? = ""
        @objc var isDownloaded = false
    }
}

