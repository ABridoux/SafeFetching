//
// SafeFetching
// Copyright © 2021-present Alexis Bridoux.
// MIT license, see LICENSE file for details

import SwiftSyntax
import SwiftSyntaxMacros
import SwiftSyntaxBuilder
import SwiftCompilerPlugin

// MARK: - Plugin

@main
struct SafeFetchingMacrosPlugin: CompilerPlugin {

    let providingMacros: [Macro.Type] = [
        FetchableManagedObjectMacro.self,
        FetchingIgnoredMacro.self
    ]
}

