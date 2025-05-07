//
// SafeFetching
// Copyright © 2021-present Alexis Bridoux.
// MIT license, see LICENSE file for details

import Foundation
import SwiftSyntax
import SwiftDiagnostics
import SwiftSyntaxMacros
import SwiftSyntaxBuilder
import SwiftCompilerPlugin

// MARK: - FetchingIgnoredMacro

public enum FetchingIgnoredMacro {

    static let ignoredAttribute: AttributeSyntax = "@FetchingIgnored"
}

// MARK: - AccessorMacro

extension FetchingIgnoredMacro: AccessorMacro {

    public static func expansion(
        of _: SwiftSyntax.AttributeSyntax,
        providingAccessorsOf declaration: some SwiftSyntax.DeclSyntaxProtocol,
        in _: some SwiftSyntaxMacros.MacroExpansionContext
    ) throws -> [SwiftSyntax.AccessorDeclSyntax] {
        []
    }
}

