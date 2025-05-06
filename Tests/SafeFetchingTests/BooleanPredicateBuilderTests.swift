//
// SafeFetching
// Copyright © 2021-present Alexis Bridoux.
// MIT license, see LICENSE file for details

import SafeFetching
import Testing
import CoreData

@Suite("Boolean Predicates")
struct BooleanPredicates {}

// MARK: - BooleanPredicateTests

extension BooleanPredicates {

    @Test("Comparison Formats")
    func comparisonFormats() {
        testNSFormat({ $0.property == "Donald" }, expecting: #"property == "Donald""#)
        testNSFormat({ $0.property != "Donald" }, expecting: #"property != "Donald""#)
        testNSFormat({ $0.score > 10 }, expecting: "score > 10")
        testNSFormat({ $0.score >= 10 }, expecting: "score >= 10")
        testNSFormat({ $0.score < 10 }, expecting: "score < 10")
        testNSFormat({ $0.score <= 10 }, expecting: "score <= 10")
        testNSFormat({ $0.isAdmin == true }, expecting: "isAdmin == 1")
        testNSFormat({ $0.isAdmin == false }, expecting: "isAdmin == 0")
        testNSFormat({ !$0.isAdmin }, expecting: "isAdmin == 0")
        testNSFormat({ $0.property == nil }, expecting: "property == nil")

        let date = Date()
        testNSFormat({ $0.stubDate == date }, expecting: #"stubDate == CAST(\#(date.timeIntervalSinceReferenceDate), "NSDate")"#)

        testNSFormat({ $0.stubRelationship == nil }, expecting: "stubRelationship == nil")
        testNSFormat({ $0.stubRelationship.property == "Toto" }, expecting: #"stubRelationship.property == "Toto""#)
    }
//
//    func testString() {
//        testNSFormat(\.property, .hasPrefix("Desp"), expecting: #"property BEGINSWITH "Desp""#)
//        testNSFormat(\.property, .hasNoPrefix("Desp"), expecting: #"NOT property BEGINSWITH "Desp""#)
//        testNSFormat(\.property, .hasSuffix("Desp"), expecting: #"property ENDSWITH "Desp""#)
//        testNSFormat(\.property, .hasNoSuffix("Desp"), expecting: #"NOT property ENDSWITH "Desp""#)
//        testNSFormat(\.property, .contains("Desp"), expecting: #"property CONTAINS "Desp""#)
//        testNSFormat(\.property, .doesNotContain("Desp"), expecting: #"NOT property CONTAINS "Desp""#)
//        testNSFormat(\.property, .matches(".*"), expecting: #"property MATCHES ".*""#)
//        testNSFormat(\.property, .doesNotMatch(".*"), expecting: #"NOT property MATCHES ".*""#)
//    }
//
//    func testStringWithEscaping() {
//        testNSFormat(predicate: \.property == #"Quote ""#, expecting: #"property == "Quote \"""#)
//        testNSFormat(predicate: \.property == #"Quote \"#, expecting: #"property == "Quote \\""#)
//        testNSFormat(predicate: \.property == #"Quote ("#, expecting: #"property == "Quote (""#)
//    }
//
//    func testString_comparisonOptions() {
//        testNSFormat(\.property, .hasPrefix("Desp", options: .caseInsensitive), expecting: #"property BEGINSWITH[c] "Desp""#)
//        testNSFormat(\.property, .hasPrefix("Desp", options: .diacriticInsensitive), expecting: #"property BEGINSWITH[d] "Desp""#)
//        testNSFormat(\.property, .hasPrefix("Desp", options: .diacriticAndCaseInsensitive), expecting: #"property BEGINSWITH[cd] "Desp""#)
//        testNSFormat(\.property, .hasPrefix("Desp", options: .normalized), expecting: #"property BEGINSWITH[n] "Desp""#)
//    }
//
//    func testComparisonFormats_RawRepresentable() {
//        testNSFormat(predicate: \.stubRaw == .foo, expecting: #"stubRaw == 1"#)
//        testNSFormat(predicate: \.stubRaw != .bar, expecting: #"stubRaw != 2"#)
//        testNSFormat(predicate: \.stubForcedRaw >= .foo, expecting: #"stubForcedRaw >= 1"#)
//        testNSFormat(predicate: \.stubForcedRaw > .foo, expecting: #"stubForcedRaw > 1"#)
//        testNSFormat(predicate: \.stubForcedRaw <= .foo, expecting: #"stubForcedRaw <= 1"#)
//        testNSFormat(predicate: \.stubForcedRaw < .foo, expecting: #"stubForcedRaw < 1"#)
//    }
//
//    func testRawRepresentable() {
//        testNSFormat(\.stubRaw, .isIn([.foo, .bar]), expecting: "stubRaw IN {1, 2}")
//        testNSFormat(\.stubRaw, .isIn(.foo, .bar), expecting: "stubRaw IN {1, 2}")
//        testNSFormat(\.stubRaw, .isNotIn([.foo, .bar]), expecting: "NOT stubRaw IN {1, 2}")
//        testNSFormat(\.stubRaw, .isNotIn(.foo, .bar), expecting: "NOT stubRaw IN {1, 2}")
//
//        testNSFormat(\.stubForcedRaw, .isIn([.foo, .bar]), expecting: "stubForcedRaw IN {1, 2}")
//        testNSFormat(\.stubForcedRaw, .isIn(.foo, .bar), expecting: "stubForcedRaw IN {1, 2}")
//        testNSFormat(\.stubForcedRaw, .isNotIn([.foo, .bar]), expecting: "NOT stubForcedRaw IN {1, 2}")
//        testNSFormat(\.stubForcedRaw, .isNotIn(.foo, .bar), expecting: "NOT stubForcedRaw IN {1, 2}")
//    }
//
//    func testOptionSet() {
//        testNSFormat(predicate: \.stubOption * .intersects([.bar, .foo]), expecting: "stubOption & 3 == 3")
//        testNSFormat(predicate: \.stubOption * .doesNotIntersect([.foo, .bar]), expecting: "stubOption & 3 != 3")
//        testNSFormat(predicate: \.stubForcedOption * .intersects([.foo, .bar]), expecting: "stubForcedOption & 3 == 3")
//        testNSFormat(predicate: \.stubForcedOption * .doesNotIntersect([.foo, .bar]), expecting: "stubForcedOption & 3 != 3")
//    }
//
//    func testAdvancedFormats() {
//        testNSFormat(\.property, .isIn(["Riri", "Fifi"]), expecting: #"property IN {"Riri", "Fifi"}"#)
//        testNSFormat(\.property, .isNotIn("Riri", "Fifi"), expecting: #"NOT property IN {"Riri", "Fifi"}"#)
//        testNSFormat(\.property, .isIn(["Riri", "Fifi"]), expecting: #"property IN {"Riri", "Fifi"}"#)
//        testNSFormat(\.property, .isNotIn(["Riri", "Fifi"]), expecting: #"NOT property IN {"Riri", "Fifi"}"#)
//        testNSFormat(\.score, .isIn(1...10), expecting: #"score BETWEEN {1, 10}"#)
//        testNSFormat(\.score, .isNotIn(1...10), expecting: #"NOT score BETWEEN {1, 10}"#)
//        testNSFormat(\.score, .isIn(1..<10.5), expecting: #"1 <= score AND score < 10.5"#)
//        testNSFormat(\.score, .isNotIn(1..<10.5), expecting: #"score < 1 OR score >= 10.5"#)
//    }
}

// MARK: - Helpers

extension BooleanPredicates {
    func testNSFormat(
        _ predicate: (StubEntity.FetchableMembers) -> Builders.Predicate<StubEntity>,
        expecting format: String,
        sourceLocation: SourceLocation = #_sourceLocation
    ) {
        #expect(predicate(StubEntity.fetchableMembers).nsValue.predicateFormat == format, sourceLocation: sourceLocation)
    }
}

// MARK: - Models

extension BooleanPredicates {

    final class StubEntity: NSManagedObject, Fetchable {
        @objc var isAdmin = false
        @objc var score = 0.0
        @objc var property: String? = ""
        @objc var stubRawValue: Int = 0
        @objc var stubStringRawValue = ""
        @objc var stubRawOption: Int = 0
        @objc var stubDate = Date()

        @objc var stubRelationship: StubEntity?

        var stubRaw: StubEnum? { StubEnum(rawValue: stubRawValue) }
        var stubForcedRaw: StubEnum { StubEnum(rawValue: stubRawValue)! }

        var stubOption: StubOptionSet? { StubOptionSet(rawValue: stubRawOption) }
        var stubForcedOption: StubOptionSet { StubOptionSet(rawValue: stubRawOption) }

        static let fetchableMembers = FetchableMembers()

        struct FetchableMembers {
            let isAdmin = FetchableMember<StubEntity, Bool>(identifier: "isAdmin")
            let score = FetchableMember<StubEntity, Double>(identifier: "score")
            let property = FetchableMember<StubEntity, String?>(identifier: "property")
            let stubDate = FetchableMember<StubEntity, Date>(identifier: "stubDate")
            let stubRelationship = FetchableMember<StubEntity, StubEntity?>(identifier: "stubRelationship")
        }
    }
}

// MARK: - Stub enum

extension BooleanPredicates {

    enum StubEnum: Int, Comparable, DatabaseValue, DatabaseTestValue {
        case foo = 1
        case bar = 2

        static func < (lhs: BooleanPredicates.StubEnum, rhs: BooleanPredicates.StubEnum) -> Bool {
            lhs.rawValue < rhs.rawValue
        }
    }

    enum StubStringEnum: String, DatabaseTestValue {
        case foo
        case bar
    }
}

// MARK: - Stub option set

extension BooleanPredicates {

    struct StubOptionSet: OptionSet, DatabaseValue, DatabaseTestValue {
        let rawValue: Int

        static let foo = StubOptionSet(rawValue: 1 << 0)
        static let bar = StubOptionSet(rawValue: 1 << 1)
    }
}
