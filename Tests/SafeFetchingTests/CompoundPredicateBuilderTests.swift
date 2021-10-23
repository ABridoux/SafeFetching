//
// SafeFetching
// Copyright © 2021-present Alexis Bridoux.
// MIT license, see LICENSE file for details

import SafeFetching
import XCTest

final class CompoundPredicateTests: XCTestCase {

    func testAnd() {
        testNSFormat(predicate: \.score == 10 && \.name == "Toto", expecting: #"score == 10 AND name == "Toto""#)
    }

    func testAndPredicateRightValue() {
        testNSFormat(predicate: \.score > 10 && \.name * .hasPrefix("Toto"), expecting: #"score > 10 AND name BEGINSWITH "Toto""#)
    }

}

// MARK: - Helpers

extension CompoundPredicateTests {

    func testNSFormat<LeftValue, LeftTestValue, RightValue, RightTestValue>(
        predicate: Builders.CompoundPredicate<StubEntity, LeftValue, LeftTestValue,RightValue, RightTestValue>,
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
    }
}

