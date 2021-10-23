//
// SafeFetching
// Copyright © 2021-present Alexis Bridoux.
// MIT license, see LICENSE file for details

import SafeFetching
import XCTest

final class BooleanPredicateTests: XCTestCase {

    func testComparisonFormats() {
        testNSFormat(predicate: \.property == "Donald", expecting: #"property == "Donald""#)
        testNSFormat(predicate: \.property != "Donald", expecting: #"property != "Donald""#)
        testNSFormat(predicate: \.score > 10, expecting: "score > 10")
        testNSFormat(predicate: \.score >= 10, expecting: "score >= 10")
        testNSFormat(predicate: \.score < 10, expecting: "score < 10")
        testNSFormat(predicate: \.score <= 10, expecting: "score <= 10")
    }

    func testString() {
        testNSFormat(\.property, .hasPrefix("Desp"), expecting: #"property BEGINSWITH "Desp""#)
        testNSFormat(\.property, .hasNoPrefix("Desp"), expecting: #"NOT property BEGINSWITH "Desp""#)
        testNSFormat(\.property, .hasSuffix("Desp"), expecting: #"property ENDSWITH "Desp""#)
        testNSFormat(\.property, .hasNoSuffix("Desp"), expecting: #"NOT property ENDSWITH "Desp""#)
        testNSFormat(\.property, .contains("Desp"), expecting: #"property CONTAINS "Desp""#)
        testNSFormat(\.property, .doesNotContain("Desp"), expecting: #"NOT property CONTAINS "Desp""#)
        testNSFormat(\.property, .matches(".*"), expecting: #"property MATCHES ".*""#)
        testNSFormat(\.property, .doesNotMatch(".*"), expecting: #"NOT property MATCHES ".*""#)
    }

    func testAdvancedFormats() {
        testNSFormat(\.property, .isIn(["Riri", "Fifi"]), expecting: #"property IN {"Riri", "Fifi"}"#)
        testNSFormat(\.property, .isNotIn("Riri", "Fifi"), expecting: #"NOT property IN {"Riri", "Fifi"}"#)
        testNSFormat(\.property, .isIn(["Riri", "Fifi"]), expecting: #"property IN {"Riri", "Fifi"}"#)
        testNSFormat(\.property, .isNotIn(["Riri", "Fifi"]), expecting: #"NOT property IN {"Riri", "Fifi"}"#)
        testNSFormat(\.score, .isIn(1...10), expecting: #"score BETWEEN {1, 10}"#)
        testNSFormat(\.score, .isNotIn(1...10), expecting: #"NOT score BETWEEN {1, 10}"#)
        testNSFormat(\.score, .isIn(1..<10.5), expecting: #"1 <= score AND score < 10.5"#)
        testNSFormat(\.score, .isNotIn(1..<10.5), expecting: #"1 > score OR score >= 10.5"#)
    }
}

// MARK: - Helpers

extension BooleanPredicateTests {

    func testNSFormat(
        predicate: Builders.Predicate<StubEntity>,
        expecting format: String
    ) {
        XCTAssertEqual(predicate.nsValue.predicateFormat, format)
    }

    func testNSFormat<Value, TestValue>(
        _ keyPath: KeyPath<StubEntity, Value>,
        _ predicateRightValue: Builders.PredicateRightValue<StubEntity, Value, TestValue>,
        expecting format: String
    ) {
        let predicateFormat = predicateRightValue.predicate(keyPath).nsValue.predicateFormat
        XCTAssertEqual(predicateFormat, format)
    }
}

// MARK: - Models

extension BooleanPredicateTests {

    final class StubEntity: NSManagedObject {

        @objc var score = 0.0
        @objc var property: String? = ""
    }
}
