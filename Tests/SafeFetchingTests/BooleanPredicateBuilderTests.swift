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
        testNSFormat(predicate: \.property == nil, expecting: "property == nil")
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

    func testComparisonFormats_RawRepresentable() {
        testNSFormat(predicate: .stubRaw == .foo, expecting: #"stubRaw == 1"#)
        testNSFormat(predicate: .stubRaw != .bar, expecting: #"stubRaw != 2"#)
        testNSFormat(predicate: .stubForcedRaw >= .foo, expecting: #"stubForcedRaw >= 1"#)
        testNSFormat(predicate: .stubForcedRaw > .foo, expecting: #"stubForcedRaw > 1"#)
        testNSFormat(predicate: .stubForcedRaw <= .foo, expecting: #"stubForcedRaw <= 1"#)
        testNSFormat(predicate: .stubForcedRaw < .foo, expecting: #"stubForcedRaw < 1"#)
    }

    func testRawRepresentable() {
        testNSFormat(.stubRaw, .isIn([.foo, .bar]), expecting: "stubRaw IN {1, 2}")
        testNSFormat(.stubRaw, .isIn(.foo, .bar), expecting: "stubRaw IN {1, 2}")
        testNSFormat(.stubRaw, .isNotIn([.foo, .bar]), expecting: "NOT stubRaw IN {1, 2}")
        testNSFormat(.stubRaw, .isNotIn(.foo, .bar), expecting: "NOT stubRaw IN {1, 2}")

        testNSFormat(.stubForcedRaw, .isIn([.foo, .bar]), expecting: "stubForcedRaw IN {1, 2}")
        testNSFormat(.stubForcedRaw, .isIn(.foo, .bar), expecting: "stubForcedRaw IN {1, 2}")
        testNSFormat(.stubForcedRaw, .isNotIn([.foo, .bar]), expecting: "NOT stubForcedRaw IN {1, 2}")
        testNSFormat(.stubForcedRaw, .isNotIn(.foo, .bar), expecting: "NOT stubForcedRaw IN {1, 2}")
    }

    func testOptionSet() {
        testNSFormat(predicate: .stubOption * .intersects([.foo, .bar]), expecting: "stubOption & 3 == stubOption")
        testNSFormat(predicate: .stubOption * .doesNotIntersect([.foo, .bar]), expecting: "stubOption & 3 != stubOption")
        testNSFormat(predicate: .stubForcedOption * .intersects([.foo, .bar]), expecting: "stubForcedOption & 3 == stubForcedOption")
        testNSFormat(predicate: .stubForcedOption * .doesNotIntersect([.foo, .bar]), expecting: "stubForcedOption & 3 != stubForcedOption")
    }

    func testStringKeyPath_DatabaseValue() {
        testNSFormat(predicate: .stubDatabaseValue == 10, expecting: "stubDatabaseValue == 10")
    }

    func testAdvancedFormats() {
        testNSFormat(\.property, .isIn(["Riri", "Fifi"]), expecting: #"property IN {"Riri", "Fifi"}"#)
        testNSFormat(\.property, .isNotIn("Riri", "Fifi"), expecting: #"NOT property IN {"Riri", "Fifi"}"#)
        testNSFormat(\.property, .isIn(["Riri", "Fifi"]), expecting: #"property IN {"Riri", "Fifi"}"#)
        testNSFormat(\.property, .isNotIn(["Riri", "Fifi"]), expecting: #"NOT property IN {"Riri", "Fifi"}"#)
        testNSFormat(\.score, .isIn(1...10), expecting: #"score BETWEEN {1, 10}"#)
        testNSFormat(\.score, .isNotIn(1...10), expecting: #"NOT score BETWEEN {1, 10}"#)
        testNSFormat(\.score, .isIn(1..<10.5), expecting: #"1 <= score AND score < 10.5"#)
        testNSFormat(\.score, .isNotIn(1..<10.5), expecting: #"score < 1 OR score >= 10.5"#)
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
        _ predicateRightValue: Builders.KeyPathPredicateRightValue<StubEntity, Value, TestValue>,
        expecting format: String
    ) {
        let predicateFormat = predicateRightValue.predicate(keyPath).nsValue.predicateFormat
        XCTAssertEqual(predicateFormat, format)
    }

    func testNSFormat<Value, TestValue>(
        _ key: StringKeyPath<StubEntity, Value>,
        _ predicateRightValue: Builders.StringKeyPathPredicateRightValue<StubEntity, Value, TestValue>,
        expecting format: String
    ) {
        let predicateFormat = predicateRightValue.predicate(key).nsValue.predicateFormat
        XCTAssertEqual(predicateFormat, format)
    }
}

// MARK: - Models

extension BooleanPredicateTests {

    final class StubEntity: NSManagedObject {

        @objc var score = 0.0
        @objc var property: String? = ""
        @objc var stubRawValue: Int = 0
        @objc var stubRawOption: Int = 0

        var stubRaw: StubEnum? { StubEnum(rawValue: stubRawValue) }
        var stubForcedRaw: StubEnum { StubEnum(rawValue: stubRawValue)! }

        var stubOption: StubOptionSet? { StubOptionSet(rawValue: stubRawOption) }
        var stubForcedOption: StubOptionSet { StubOptionSet(rawValue: stubRawOption) }
    }
}

// MARK: - Stub enum

extension BooleanPredicateTests {

    enum StubEnum: Int, Comparable, DatabaseTestValue {
        case foo = 1
        case bar = 2

        static func < (lhs: BooleanPredicateTests.StubEnum, rhs: BooleanPredicateTests.StubEnum) -> Bool {
            lhs.rawValue < rhs.rawValue
        }
    }
}

extension StringKeyPath where Entity == BooleanPredicateTests.StubEntity, Value == BooleanPredicateTests.StubEnum {

    static var stubRaw: Self {
        Self(key: "stubRaw")
    }
}

extension StringKeyPath where Entity == BooleanPredicateTests.StubEntity, Value == BooleanPredicateTests.StubEnum {

    static var stubForcedRaw: Self {
        Self(key: "stubForcedRaw")
    }
}

// MARK: - Stub option set

extension BooleanPredicateTests {

    struct StubOptionSet: OptionSet, DatabaseTestValue {
        let rawValue: Int

        static let foo = StubOptionSet(rawValue: 1 << 0)
        static let bar = StubOptionSet(rawValue: 1 << 1)
    }
}

extension StringKeyPath where Entity == BooleanPredicateTests.StubEntity, Value == BooleanPredicateTests.StubOptionSet? {

    static var stubOption: Self {
        Self(key: "stubOption")
    }
}

extension StringKeyPath where Entity == BooleanPredicateTests.StubEntity, Value == BooleanPredicateTests.StubOptionSet {

    static var stubForcedOption: Self {
        Self(key: "stubForcedOption")
    }
}

// MARK: - Stub database value

extension StringKeyPath where Entity == BooleanPredicateTests.StubEntity, Value == Int32 {

    static var stubDatabaseValue: Self { Self(key: "stubDatabaseValue") }
}
