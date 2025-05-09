//
// SafeFetching
// Copyright © 2021-present Alexis Bridoux.
// MIT license, see LICENSE file for details

import SafeFetching
import CoreData
import Testing

// MARK: - CompoundPredicates

@Suite("Compound Predicate")
struct CompoundPredicates {}

// MARK: - Simple

extension CompoundPredicates {

    @Test("And")
    func and() {
        testNSFormat({ $0.score == 10 && $0.name == "Toto" }, expecting: #"score == 10 AND name == "Toto""#)
    }

    @Test("Or")
    func or() {
        testNSFormat({ $0.score == 10 || $0.name == "Toto" }, expecting: #"score == 10 OR name == "Toto""#)
    }
}

// MARK: - Mix

extension CompoundPredicates {

    @Test("And Prefix")
    func andPrefix() {
        testNSFormat({ $0.score == 10 && $0.name.hasPrefix("Toto") }, expecting: #"score == 10 AND name BEGINSWITH "Toto""#)
    }

    @Test("And Compound")
    func andCompound() {
        testNSFormat(
            { $0.score > 10 && $0.name.hasPrefix("To") && $0.name.hasSuffix("ta") },
            expecting: #"(score > 10 AND name BEGINSWITH "To") AND name ENDSWITH "ta""#
        )
    }

    @Test("Compound Precedence")
    func precedence() {
        testNSFormat(
            { $0.score > 10 && $0.name.hasPrefix("To") || $0.name.hasSuffix("ta") },
            expecting: #"(score > 10 AND name BEGINSWITH "To") OR name ENDSWITH "ta""#
        )
    }

    @Test("Compound Precedence")
    func brackets() {
        testNSFormat(
            { $0.score > 10 && ($0.name.hasPrefix("To") || $0.name.hasSuffix("ta")) },
            expecting: #"score > 10 AND (name BEGINSWITH "To" OR name ENDSWITH "ta")"#
        )
    }
}

// MARK: - Single Boolean

extension CompoundPredicates {

    @Test("And Single Boolean Right")
    func andSingleBooleanRight() {
        testNSFormat({ $0.isDownloaded && $0.name == "Toto" }, expecting: #"isDownloaded == 1 AND name == "Toto""#)
    }

    @Test("Or Single Boolean Left")
    func orSingleBooleanLeft() {
        testNSFormat({ $0.name == "Toto" || $0.isDownloaded }, expecting: #"name == "Toto" OR isDownloaded == 1"#)
    }

    @Test("Both Boolean FetchableMember")
    func bothBooleanFetchableMember() {
        testNSFormat({ $0.isDownloaded && $0.isDownloaded }, expecting: #"isDownloaded == 1 AND isDownloaded == 1"#)
        testNSFormat({ $0.isDownloaded || $0.isDownloaded }, expecting: #"isDownloaded == 1 OR isDownloaded == 1"#)
    }
}

// MARK: - Helpers

extension CompoundPredicates {

    func testNSFormat(
        _ predicate: (StubEntity.FetchableMembers) -> Builders.Predicate<StubEntity>,
        expecting format: String,
        sourceLocation: SourceLocation = #_sourceLocation
    ) {
        #expect(predicate(StubEntity.fetchableMembers).nsValue.predicateFormat == format, sourceLocation: sourceLocation)
    }
}


// MARK: - Models

extension CompoundPredicates {

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

