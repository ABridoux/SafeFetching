//
// SafeFetching
// Copyright © 2021-present Alexis Bridoux.
// MIT license, see LICENSE file for details

@_spi(SafeFetching) import SafeFetching
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

        testNSFormat({ $0.stubOptionalRelationship == nil }, expecting: "stubOptionalRelationship == nil")
        testNSFormat({ $0.stubRelationship.property == "Toto" }, expecting: #"stubRelationship.property == "Toto""#)
        testNSFormat({ $0.stubOptionalRelationship.property == "Toto" }, expecting: #"stubOptionalRelationship.property == "Toto""#)
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

// MARK: - Relationship

extension BooleanPredicates {

    @Test("Relationship and Compound")
    func relationshipAndCompound() {
        testNSFormat({ $0.score == 1 && $0.stubRelationship.property == "Toto" }, expecting: #"score == 1 AND stubRelationship.property == "Toto""#)
    }
}

// MARK: - NSPredicate

extension BooleanPredicates {

    @Test("NSPredicate.safe")
    func nsPredicateSafe() {
        var predicate = NSPredicate.safe(on: StubEntity.self) { $0.isAdmin }
        #expect(predicate.predicateFormat == "isAdmin == 1")

        predicate = NSPredicate.safe(on: StubEntity.self) { $0.stubRelationship.isDownloaded }
        #expect(predicate.predicateFormat == "stubRelationship.isDownloaded == 1")
    }
}

// MARK: - Helpers

extension BooleanPredicates {

    func testNSFormat<Entity: Fetchable>(
        _ predicate: (StubEntity.FetchableMembers) -> Builders.Predicate<Entity>,
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
        @objc var stubRawValue: Int16 = 0
        @objc var stubStringRawValue = ""
        @objc var stubRawOption: Int16 = 0
        @objc var stubDate = Date()

        @objc var stubRelationship = StubEntityBis()
        @objc var stubOptionalRelationship: StubEntityBis?

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
            let stubRelationship = FetchableMember<StubEntity, StubEntityBis>(identifier: "stubRelationship")
            let stubOptionalRelationship = FetchableMember<StubEntity, StubEntityBis?>(identifier: "stubOptionalRelationship")
        }
    }

    final class StubEntityBis: NSManagedObject, Fetchable {

        @objc var property: String? = ""
        @objc var isDownloaded: Bool = false

        static let fetchableMembers = FetchableMembers()

        struct FetchableMembers {
            let property = FetchableMember<StubEntityBis, String?>(identifier: "property")
            let isDownloaded = FetchableMember<StubEntityBis, Bool>(identifier: "isDownloaded")
        }
    }
}

// MARK: - Stub enum

extension BooleanPredicates {

    enum StubEnum: Int16, Comparable, FetchableValue {
        case foo = 1
        case bar = 2

        static func < (lhs: BooleanPredicates.StubEnum, rhs: BooleanPredicates.StubEnum) -> Bool {
            lhs.rawValue < rhs.rawValue
        }
    }

    enum StubStringEnum: String, FetchableValue {
        case foo
        case bar
    }
}

// MARK: - Stub option set

extension BooleanPredicates {

    struct StubOptionSet: OptionSet, FetchableValue {
        let rawValue: Int16

        static let foo = StubOptionSet(rawValue: 1 << 0)
        static let bar = StubOptionSet(rawValue: 1 << 1)
    }
}
