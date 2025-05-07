//
// SafeFetching
// Copyright © 2021-present Alexis Bridoux.
// MIT license, see LICENSE file for details

import SafeFetching
import Testing
import CoreData

// MARK: - BooleanPredicates

@Suite("Boolean Predicates")
struct BooleanPredicates {}

// MARK: - Comparison

extension BooleanPredicates {

    @Test("Boolean Formats")
    func comparison() {
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

    @Test("Inversion")
    func inversion() {
        testNSFormat({ !$0.property.hasPrefix("Desp") }, expecting: #"NOT property BEGINSWITH "Desp""#)
        testNSFormat({ $0.property.hasPrefix("Desp") == false }, expecting: #"NOT property BEGINSWITH "Desp""#)
        testNSFormat({ !$0.property.hasPrefix("Desp") == false }, expecting: #"property BEGINSWITH "Desp""#)
        testNSFormat({ ![.foo, .bar].contains($0.stubRaw) }, expecting: "NOT stubRaw IN {1, 2}")
    }
}

// MARK: - String

extension BooleanPredicates {

    @Test("String Comparison")
    func stringOperation() {
        testNSFormat({ $0.property.hasPrefix("Desp") }, expecting: #"property BEGINSWITH "Desp""#)
        testNSFormat({ $0.property.hasSuffix("Desp") }, expecting: #"property ENDSWITH "Desp""#)
        testNSFormat({ $0.property.contains("Desp") }, expecting: #"property CONTAINS "Desp""#)
        testNSFormat({ $0.property.matches("Desp") }, expecting: #"property MATCHES "Desp""#)
    }

    @Test("String Escaping")
    func stringEscaping() {
        testNSFormat({ $0.property == #"Quote ""# }, expecting: #"property == "Quote \"""#)
        testNSFormat({ $0.property == #"Quote \"# }, expecting: #"property == "Quote \\""#)
        testNSFormat({ $0.property == #"Quote ("# }, expecting: #"property == "Quote (""#)
    }

    @Test("String Comparison Options")
    func stringComparisonOptions() {
        testNSFormat({ $0.property.hasPrefix("Desp", options: .caseInsensitive) }, expecting: #"property BEGINSWITH[c] "Desp""#)
        testNSFormat({ $0.property.hasPrefix("Desp", options: .diacriticInsensitive) }, expecting: #"property BEGINSWITH[d] "Desp""#)
        testNSFormat({ $0.property.hasPrefix("Desp", options: .diacriticAndCaseInsensitive) }, expecting: #"property BEGINSWITH[cd] "Desp""#)
        testNSFormat({ $0.property.hasPrefix("Desp", options: .normalized) }, expecting: #"property BEGINSWITH[n] "Desp""#)
    }
}

// MARK: - RawRepresentable

extension BooleanPredicates {

    @Test("RawRepresentable")
    func rawRepresentable() {
        testNSFormat({ $0.stubRaw == .foo }, expecting: #"stubRaw == 1"#)
        testNSFormat({ $0.stubRaw != .bar }, expecting: #"stubRaw != 2"#)
        testNSFormat({ $0.stubForcedRaw >= .foo }, expecting: #"stubForcedRaw >= 1"#)
        testNSFormat({ $0.stubForcedRaw > .foo }, expecting: #"stubForcedRaw > 1"#)
        testNSFormat({ $0.stubForcedRaw <= .foo }, expecting: #"stubForcedRaw <= 1"#)
        testNSFormat({ $0.stubForcedRaw < .foo }, expecting: #"stubForcedRaw < 1"#)
    }

    @Test("RawRepresentable in Collection")
    func rawRepresentable_collection() {
        testNSFormat({ $0.stubRaw.isIn([.foo, .bar]) }, expecting: "stubRaw IN {1, 2}")
        testNSFormat({ $0.stubRaw.isIn(.foo, .bar) }, expecting: "stubRaw IN {1, 2}")
        testNSFormat({ [.foo, .bar].contains($0.stubRaw) }, expecting: "stubRaw IN {1, 2}")
    }
}

// MARK: - OptionSet

extension BooleanPredicates {

    @Test("OptionSet")
    func optionSet() {
        testNSFormat({ $0.stubOption.intersects([.bar, .foo]) }, expecting: "stubOption & 3 == 3")
        testNSFormat({ $0.stubForcedOption.intersects([.bar, .foo]) }, expecting: "stubForcedOption & 3 == 3")
        let options: StubOptionSet = [.foo, .bar]
        testNSFormat({ options.intersects($0.stubForcedOption) }, expecting: "stubForcedOption & 3 == 3")
    }
}

// MARK: - Range

extension BooleanPredicates {

    @Test("Range")
    func range() {
        testNSFormat({ $0.score.isIn((1..<10.5)) }, expecting: #"1 <= score AND score < 10.5"#)
        testNSFormat({ $0.score.isIn((1...10)) }, expecting: #"score BETWEEN {1, 10}"#)
    }
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
            let stubRaw = FetchableMember<StubEntity, StubEnum?>(identifier: "stubRaw")
            let stubForcedRaw = FetchableMember<StubEntity, StubEnum>(identifier: "stubForcedRaw")
            let stubOption = FetchableMember<StubEntity, StubOptionSet?>(identifier: "stubOption")
            let stubForcedOption = FetchableMember<StubEntity, StubOptionSet>(identifier: "stubForcedOption")
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
