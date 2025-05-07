//
// SafeFetching
// Copyright © 2021-present Alexis Bridoux.
// MIT license, see LICENSE file for details

import XCTest
import SwiftSyntaxMacros
import SafeFetchingMacros
import SwiftSyntaxMacrosTestSupport

// MARK: - Constants

private let testMacros: [String: Macro.Type] = [
    "FetchableManagedObject": FetchableManagedObjectMacro.self
]

// MARK: - FetchableManagedObjectMacroTests

final class FetchableManagedObjectMacroTests: XCTestCase {}

// MARK: - Simple Case

extension FetchableManagedObjectMacroTests {

    func testMemberAttributes() {
        assertMacroExpansion(
            """
            @FetchableManagedObject
            final class Song: NSManagedObject {
                @NSManaged var title: String
            }
            """,
            expandedSource:
            """
            final class Song: NSManagedObject {
                @NSManaged var title: String

                internal static var fetchableMembers: FetchableMembers {
                    FetchableMembers()
                }

                internal struct FetchableMembers {
                    internal let title = FetchableMember<Song, String>(identifier: "title")
                }
            }

            extension Song: Fetchable {
            }
            """,
            macros: testMacros
        )
    }
}

// MARK: - Public Modifier

extension FetchableManagedObjectMacroTests {

    func testPublicModifier() {
        assertMacroExpansion(
            """
            @FetchableManagedObject
            public final class Song: NSManagedObject {
                @NSManaged public var title: String
            }
            """,
            expandedSource:
            """
            public final class Song: NSManagedObject {
                @NSManaged public var title: String

                public static var fetchableMembers: FetchableMembers {
                    FetchableMembers()
                }

                public struct FetchableMembers {
                    public let title = FetchableMember<Song, String>(identifier: "title")
                }
            }

            extension Song: Fetchable {
            }
            """,
            macros: testMacros
        )
    }
}

// MARK: - FetchingIgnored

extension FetchableManagedObjectMacroTests {

    func testFetchingIgnored() {
        assertMacroExpansion(
            """
            @FetchableManagedObject
            final class Song: NSManagedObject {
                @NSManaged var title: String
            
                @FetchingIgnored
                var nonPersistedProperty = 0
            }
            """,
            expandedSource:
            """
            final class Song: NSManagedObject {
                @NSManaged var title: String
            
                @FetchingIgnored
                var nonPersistedProperty = 0

                internal static var fetchableMembers: FetchableMembers {
                    FetchableMembers()
                }

                internal struct FetchableMembers {
                    internal let title = FetchableMember<Song, String>(identifier: "title")
                }
            }

            extension Song: Fetchable {
            }
            """,
            macros: testMacros
        )
    }
}

// MARK: - Static

extension FetchableManagedObjectMacroTests {

    func testStaticMembersAreIgnored() {
        assertMacroExpansion(
            """
            @FetchableManagedObject
            final class Song: NSManagedObject {
                @NSManaged var title: String
            
                static let property = 0
            }
            """,
            expandedSource:
            """
            final class Song: NSManagedObject {
                @NSManaged var title: String
            
                static let property = 0

                internal static var fetchableMembers: FetchableMembers {
                    FetchableMembers()
                }

                internal struct FetchableMembers {
                    internal let title = FetchableMember<Song, String>(identifier: "title")
                }
            }

            extension Song: Fetchable {
            }
            """,
            macros: testMacros
        )
    }
}

// MARK: - Diagnostic

extension FetchableManagedObjectMacroTests {

    func testDiagnostic_onlyApplicableToClass() {
        assertMacroExpansion(
            """
            @FetchableManagedObject
            struct Song {
                public var title: String
            }
            """,
            expandedSource:
            """
            struct Song {
                public var title: String
            }

            extension Song: Fetchable {
            }
            """,
            diagnostics: [
                .init(
                    message: "@FetchableManagedObject is only applicable to a class",
                    line: 1,
                    column: 1,
                    fixIts: []
                )
            ],
            macros: testMacros
        )
    }

    func testDiagnostic_typeInference() {
        assertMacroExpansion(
            """
            @FetchableManagedObject
            final class Song: NSManagedObject {
                @NSManaged public var title = MyStruct()
            }
            """,
            expandedSource:
            """
            final class Song: NSManagedObject {
                @NSManaged public var title = MyStruct()
            
                internal static var fetchableMembers: FetchableMembers {
                    FetchableMembers()
                }

                internal struct FetchableMembers {
                }
            }

            extension Song: Fetchable {
            }
            """,
            diagnostics: [
                .init(
                    message: "Type of 'title' cannot be inferred by the @FetchableManagedObject macro",
                    line: 3,
                    column: 27,
                    fixIts: [FixItSpec(message: "Add explicit type declaration")]
                )
            ],
            macros: testMacros
        )
    }
}
