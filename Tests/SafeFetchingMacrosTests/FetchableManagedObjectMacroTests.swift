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
